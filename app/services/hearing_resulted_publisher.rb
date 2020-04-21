# frozen_string_literal: true

class HearingResultedPublisher < ApplicationService
  def initialize(hearing_id:, shared_time:, connection: LaaConnector.call)
    @hearing = Hearing.find(hearing_id)
    @shared_time = shared_time
    @connection = connection
    @schema = JSON.parse(File.open(Rails.root.join('lib/schemas/api/hearing-resulted.json')).read)
    @url = 'hearings'
    register_dependant_schemas!
  end

  def call
    errors = JSON::Validator.fully_validate(schema, permitted_params.to_json)
    raise Errors::InvalidParams, errors if errors.present?

    connection.post(url, permitted_params)
  end

  private

  attr_reader :hearing, :connection, :shared_time, :schema, :url

  def permitted_params
    { hearing: hearing.to_builder.attributes!, sharedTime: shared_time }
  end

  def register_dependant_schemas!
    # Since apiCourtsDefinitions.json does not map to the expected directory structure for both the api responses and the model schemas,
    # we are overriding the id, to ensure that the validator can find the definitions without blowing up.
    courts_definitions = JSON.parse(File.open(Rails.root.join('lib/schemas/global/apiCourtsDefinitions.json')).read)
    courts_definitions['id'] = 'http://justice.gov.uk/hearing/external/global/apicourtsDefinitions.json'
    JSON::Validator.add_schema(JSON::Schema.new(courts_definitions, Addressable::URI.parse(courts_definitions['id'])))
    courts_definitions['id'] = 'http://justice.gov.uk/hearing/external/global/apiCourtsDefinitions.json'
    JSON::Validator.add_schema(JSON::Schema.new(courts_definitions, Addressable::URI.parse(courts_definitions['id'])))

    hearing = JSON.parse(File.open(Rails.root.join('lib/schemas/global/apiHearing.json')).read)
    hearing['id'] = 'http://justice.gov.uk/hearing/external/global/apiHearing.json'
    JSON::Validator.add_schema(JSON::Schema.new(hearing, Addressable::URI.parse(hearing['id'])))

    court_centre = JSON.parse(File.open(Rails.root.join('lib/schemas/global/apiCourtCentre.json')).read)
    court_centre['id'] = 'http://justice.gov.uk/hearing/external/global/apicourtCentre.json'
    JSON::Validator.add_schema(JSON::Schema.new(court_centre, Addressable::URI.parse(hearing['id'])))

    address = JSON.parse(File.open(Rails.root.join('lib/schemas/global/apiAddress.json')).read)
    address['id'] = 'http://justice.gov.uk/hearing/external/global/apiaddress.json'
    JSON::Validator.add_schema(JSON::Schema.new(address, Addressable::URI.parse(address['id'])))

    lja_details = JSON.parse(File.open(Rails.root.join('lib/schemas/global/apiLjaDetails.json')).read)
    lja_details['id'] = 'http://justice.gov.uk/hearing/external/global/apiljaDetails.json'
    JSON::Validator.add_schema(JSON::Schema.new(lja_details, Addressable::URI.parse(lja_details['id'])))

    hearing_type = JSON.parse(File.open(Rails.root.join('lib/schemas/global/apiHearingType.json')).read)
    hearing_type['id'] = 'http://justice.gov.uk/hearing/external/global/apihearingType.json'
    JSON::Validator.add_schema(JSON::Schema.new(hearing_type, Addressable::URI.parse(hearing_type['id'])))

    hearing_day = JSON.parse(File.open(Rails.root.join('lib/schemas/global/apiHearingDay.json')).read)
    hearing_day['id'] = 'http://justice.gov.uk/hearing/external/global/apihearingDay.json'
    JSON::Validator.add_schema(JSON::Schema.new(hearing_day, Addressable::URI.parse(hearing_day['id'])))

    judicial_role = JSON.parse(File.open(Rails.root.join('lib/schemas/global/apiJudicialRole.json')).read)
    judicial_role['id'] = 'http://justice.gov.uk/hearing/external/global/apijudicialRole.json'
    JSON::Validator.add_schema(JSON::Schema.new(judicial_role, Addressable::URI.parse(judicial_role['id'])))

    judicial_role_type = JSON.parse(File.open(Rails.root.join('lib/schemas/global/apiJudicialRoleType.json')).read)
    judicial_role_type['id'] = 'http://justice.gov.uk/hearing/external/global/apiJudicialRoleType.json'
    JSON::Validator.add_schema(JSON::Schema.new(judicial_role_type, Addressable::URI.parse(judicial_role_type['id'])))
  end
end
