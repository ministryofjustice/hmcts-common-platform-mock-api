# frozen_string_literal: true

class CourtApplicationSearch < ApplicationService
  def initialize(params)
    @params = params
    @schema = JSON.parse(File.open(Rails.root.join("lib/schemas/api/progression.query.courtApplicationRequest.json")).read)
    register_dependant_schemas!
  end

  def call
    errors = JSON::Validator.fully_validate(@schema, permitted_params.to_json)
    raise Errors::InvalidParams, errors if errors.present?

    CourtApplication.find(params[:applicationId])
  end

private

  attr_reader :params, :schema

  def permitted_params
    params.permit(:applicationId)
  end

  def register_dependant_schemas!
    # Since apiCourtsDefinitions.json does not map to the expected directory structure for both the api responses and the model schemas,
    # we are overriding the id, to ensure that the validator can find the definitions without blowing up.
    definitions = JSON.parse(File.open(Rails.root.join("lib/schemas/global/apiCourtsDefinitions.json")).read)
    definitions["id"] = "http://justice.gov.uk/core/courts/external/courtsDefinitions.json"
    JSON::Validator.add_schema(JSON::Schema.new(definitions, Addressable::URI.parse(definitions["id"])))
  end
end
