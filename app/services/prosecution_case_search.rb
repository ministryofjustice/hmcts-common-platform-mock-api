# frozen_string_literal: true

class ProsecutionCaseSearch < ApplicationService
  def initialize(params)
    @params = params
    @schema = JSON.parse(File.open(Rails.root.join('lib/schemas/api/search-prosecutionCaseRequest.json')).read)
    register_dependant_schemas!
  end

  def call
    errors = JSON::Validator.fully_validate(schema, permitted_params.to_json)
    raise Errors::InvalidParams, errors if errors.present?

    return prosecution_cases_by_reference if permitted_params['prosecutionCaseReference'].present?

    return prosecution_cases_by_nino if permitted_params['nationalInsuranceNumber'].present?

    return prosecution_cases_by_summons if permitted_params['arrestSummonsNumber'].present?

    prosecution_cases_by_name_and_dob if permitted_params['dateOfBirth'].present?
  end

  private

  attr_reader :params, :schema

  def prosecution_cases_by_reference
    ProsecutionCase
      .joins(:prosecution_case_identifier)
      .where('"caseURN" = :search OR "prosecutionAuthorityReference" = :search', search: permitted_params[:prosecutionCaseReference])
  end

  def prosecution_cases_by_nino
    ProsecutionCase.joins(:defendants).where(defendants: { defendable_type: 'PersonDefendant', defendable_id: person_defendant_by_nino })
  end

  def person_defendant_by_nino
    PersonDefendant.joins(:person).where(people: { nationalInsuranceNumber: permitted_params[:nationalInsuranceNumber] })
  end

  def prosecution_cases_by_summons
    ProsecutionCase.joins(:defendants).where(defendants: { defendable_type: 'PersonDefendant', defendable_id: person_defendant_by_summons })
  end

  def person_defendant_by_summons
    PersonDefendant.where(arrestSummonsNumber: permitted_params[:arrestSummonsNumber])
  end

  def prosecution_cases_by_name_and_dob
    ProsecutionCase.joins(:defendants).where(defendants: {
                                               defendable_type: 'PersonDefendant',
                                               defendable_id: person_defendant_by_name_and_dob
                                             })
  end

  def person_defendant_by_name_and_dob
    PersonDefendant.by_name_and_dob(permitted_params.slice(:name, :dateOfBirth))
  end

  def permitted_params
    params.permit(:prosecutionCaseReference,
                  :nationalInsuranceNumber,
                  :arrestSummonsNumber,
                  :dateOfBirth,
                  :dateOfNextHearing,
                  name: %i[firstName middleName lastName])
  end

  def register_dependant_schemas!
    # Since courtsDefinitions.json does not map to the expected directory structure for both the api responses and the model schemas,
    # we are overriding the id, to ensure that the validator can find the definitions without blowing up.
    courts_definitions = JSON.parse(File.open(Rails.root.join('lib/schemas/global/courtsDefinitions.json')).read)
    courts_definitions['id'] = 'http://justice.gov.uk/unified_search_query/global/courtsDefinitions.json'
    JSON::Validator.add_schema(JSON::Schema.new(courts_definitions, Addressable::URI.parse(courts_definitions['id'])))

    defendant_name = JSON.parse(File.open(Rails.root.join('lib/schemas/global/search/defendantName.json')).read)
    defendant_name['id'] = 'http://justice.gov.uk/unified_search_query/global/search/defendantName.json'
    JSON::Validator.add_schema(JSON::Schema.new(defendant_name, Addressable::URI.parse(defendant_name['id'])))
  end
end
