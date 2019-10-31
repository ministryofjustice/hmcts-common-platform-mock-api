# frozen_string_literal: true

class ProsecutionCaseSearch < ApplicationService
  def initialize(params)
    @params = params
    @schema = JSON.parse(File.open(Rails.root.join('lib/schemas/api/search-prosecutionCaseRequest.json')).read)
  end

  def call
    errors = JSON::Validator.fully_validate(schema, permitted_params.to_json)
    raise Errors::InvalidParams, errors if errors.present?

    ProsecutionCase.all
  end

  private

  attr_reader :params, :schema

  def permitted_params
    params.permit(schema['properties'].keys)
  end
end
