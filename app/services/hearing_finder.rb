# frozen_string_literal: true

class HearingFinder < ApplicationService
  def initialize(params)
    @params = params
    @schema = JSON.parse(File.open(Rails.root.join('lib/schemas/api/results.api.hearingResultedRequest.json')).read)
    register_dependant_schemas!
  end

  def call
    errors = JSON::Validator.fully_validate(schema, permitted_params.to_json)
    raise Errors::InvalidParams, errors if errors.present?

    Hearing.find(params[:hearingId])
  end

  private

  attr_reader :params, :schema

  def permitted_params
    params.permit(:hearingId)
  end

  def register_dependant_schemas!
    # Since apiCourtsDefinitions.json does not map to the expected directory structure for both the api responses and the model schemas,
    # we are overriding the id, to ensure that the validator can find the definitions without blowing up.
    courts_definitions = JSON.parse(File.open(Rails.root.join('lib/schemas/global/apiCourtsDefinitions.json')).read)
    courts_definitions['id'] = 'http://justice.gov.uk/results/external/global/apicourtsDefinitions.json'
    JSON::Validator.add_schema(JSON::Schema.new(courts_definitions, Addressable::URI.parse(courts_definitions['id'])))
    courts_definitions['id'] = 'http://justice.gov.uk/results/external/global/apiCourtsDefinitions.json'
    JSON::Validator.add_schema(JSON::Schema.new(courts_definitions, Addressable::URI.parse(courts_definitions['id'])))
  end
end
