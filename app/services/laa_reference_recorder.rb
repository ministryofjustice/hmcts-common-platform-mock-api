# frozen_string_literal: true

class LaaReferenceRecorder < ApplicationService
  def initialize(params)
    @params = params
    @schema = JSON.parse(File.open(Rails.root.join("lib/schemas/api/progression.recordLAAReference.json")).read)
    register_dependant_schemas!
  end

  def call
    errors = JSON::Validator.fully_validate(schema, permitted_params.to_json)

    raise Errors::InvalidParams, errors if errors.present?

    reference_holder = find_reference_holder

    reference_holder.build_laa_reference if reference_holder.laa_reference.blank?

    reference_holder.laa_reference.update!(laa_reference_params)
    reference_holder.laa_reference
  end

private

  attr_reader :params, :schema

  def permitted_params
    params.permit(:prosecutionCaseId, :defendantId, :offenceId, :statusCode, :applicationReference, :statusDate)
  end

  def laa_reference_params
    permitted_params.slice(:statusCode, :applicationReference, :statusDate).merge(
      statusId: SecureRandom.uuid,
      statusDescription: "FAKE NEWS",
    )
  end

  def register_dependant_schemas!
    # Since apiCourtsDefinitions.json does not map to the expected directory structure for both the api responses and the model schemas,
    # we are overriding the id, to ensure that the validator can find the definitions without blowing up.
    courts_definitions = JSON.parse(File.open(Rails.root.join("lib/schemas/global/apiCourtsDefinitions.json")).read)
    courts_definitions["id"] = "http://justice.gov.uk/core/courts/external/apiCourtsDefinitions.json"
    JSON::Validator.add_schema(JSON::Schema.new(courts_definitions, Addressable::URI.parse(courts_definitions["id"])))
  end

  def find_reference_holder
    Offence.find_by(id: params[:offenceId]) || CourtApplication.find_by(id: params[:offenceId])
  end
end
