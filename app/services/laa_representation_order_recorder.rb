# frozen_string_literal: true

class LaaRepresentationOrderRecorder < ApplicationService
  def initialize(params)
    @params = params
    @schema = JSON.parse(File.open(Rails.root.join('lib/schemas/api/progression.recordRepresentationOrder.json')).read)
    register_dependant_schemas!
  end

  def call
    errors = JSON::Validator.fully_validate(schema, permitted_params.to_json)
    raise Errors::InvalidParams, errors if errors.present?

    offence = Offence.find(params[:offenceId])

    laa_reference = offence.laa_references.find_or_initialize_by(
      statusCode: params[:statusCode],
      applicationReference: params[:applicationReference],
      statusDate: params[:statusDate]
    )
    laa_reference.update!(laa_reference_params)
    laa_reference
  end

  private

  attr_reader :params, :schema

  def permitted_params
    params.permit(:prosecutionCaseId,
                  :defendantId,
                  :offenceId,
                  :statusCode,
                  :applicationReference,
                  :statusDate,
                  :effectiveStartDate,
                  :effectiveEndDate,
                  defenceOrganisation: {})
  end

  def laa_reference_params
    # We need to understand how a `DefenceOrganisation` maps to an `LaaReference`
    # so that we can then consume the `defenceOrganisation` param sent across by the LAA Adaptor
    permitted_params.slice(:statusCode,
                           :applicationReference,
                           :statusDate,
                           :effectiveStartDate,
                           :effectiveEndDate)
                    .merge(statusId: SecureRandom.uuid,
                           statusDescription: 'FAKE NEWS')
  end

  def register_dependant_schemas!
    # Since courtsDefinitions.json does not map to the expected directory structure for both the api responses and the model schemas,
    # we are overriding the id, to ensure that the validator can find the definitions without blowing up.
    courts_definitions = JSON.parse(File.open(Rails.root.join('lib/schemas/global/courtsDefinitions.json')).read)
    courts_definitions['id'] = 'http://justice.gov.uk/progression/global/courtsDefinitions.json'
    JSON::Validator.add_schema(JSON::Schema.new(courts_definitions, Addressable::URI.parse(courts_definitions['id'])))

    defence_organisation = JSON.parse(File.open(Rails.root.join('lib/schemas/global/defenceOrganisation.json')).read)
    defence_organisation['id'] = 'http://justice.gov.uk/progression/global/defenceOrganisation.json'
    JSON::Validator.add_schema(JSON::Schema.new(defence_organisation, Addressable::URI.parse(defence_organisation['id'])))

    organisation = JSON.parse(File.open(Rails.root.join('lib/schemas/global/organisation.json')).read)
    organisation['id'] = 'http://justice.gov.uk/progression/global/organisation.json'
    JSON::Validator.add_schema(JSON::Schema.new(organisation, Addressable::URI.parse(organisation['id'])))
  end
end
