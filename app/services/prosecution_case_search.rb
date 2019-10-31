# frozen_string_literal: true

class ProsecutionCaseSearch < ApplicationService
  def initialize(params)
    @params = params
    @schema = JSON.parse(File.open(Rails.root.join('lib/schemas/api/search-prosecutionCaseRequest.json')).read)
    normalise_schema!
  end

  def call
    errors = JSON::Validator.fully_validate(schema, permitted_params.to_json)
    raise Errors::InvalidParams, errors if errors.present?

    prosecution_cases_by_reference if permitted_params['prosecutionCaseReference'].present?
  end

  private

  attr_reader :params, :schema

  def prosecution_cases_by_reference
    ProsecutionCase
      .joins(:prosecution_case_identifier)
      .where('"caseURN" = :search OR "prosecutionAuthorityReference" = :search', search: permitted_params['prosecutionCaseReference'])
  end

  def permitted_params
    params.permit(schema['properties'].keys)
  end

  def normalise_schema!
    # Since courtsDefinitions.json does not map to the expected directory structure for both the api responses and the model schemas,
    # we are overriding the id, to ensure that the validator can find the definitions without blowing up.
    schema['id'] = 'lib/schemas/api/global/'
  end
end
