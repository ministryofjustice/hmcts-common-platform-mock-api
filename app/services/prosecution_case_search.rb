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

    return prosecution_cases_by_nino if permitted_params['defendantNINO'].present?

    return prosecution_cases_by_summons if permitted_params['defendantASN'].present?

    return prosecution_cases_by_name_and_dob if permitted_params['defendantDOB'].present?

    prosecution_cases_by_name_and_date_of_next_hearing
  end

  private

  attr_reader :params, :schema

  def prosecution_cases_by_reference
    ProsecutionCase
      .joins(:prosecution_case_identifier)
      .merge(ProsecutionCaseIdentifier.by_reference(permitted_params[:prosecutionCaseReference]))
  end

  def prosecution_cases_by_nino
    ProsecutionCase.joins(person_only_defendants: :person_defendant).merge(person_defendant_by_nino)
  end

  def person_defendant_by_nino
    PersonDefendant.joins(:person).where('"nationalInsuranceNumber" ILIKE :search', search: permitted_params[:defendantNINO])
  end

  def prosecution_cases_by_summons
    ProsecutionCase.joins(person_only_defendants: :person_defendant).merge(person_defendant_by_summons)
  end

  def person_defendant_by_summons
    PersonDefendant.where('"arrestSummonsNumber" ILIKE :search', search: permitted_params[:defendantASN])
  end

  def prosecution_cases_by_name_and_dob
    ProsecutionCase.joins(person_only_defendants: :person_defendant).merge(person_defendant_by_name_and_dob)
  end

  def person_defendant_by_name_and_dob
    PersonDefendant.by_name_and_dob(defendantName: permitted_params[:defendantName], dateOfBirth: permitted_params[:defendantDOB])
  end

  def prosecution_cases_by_name_and_date_of_next_hearing
    ProsecutionCase.joins(:defendants)
                   .merge(defendant_by_name_and_date_of_next_hearing)
  end

  def defendant_by_name_and_date_of_next_hearing
    Defendant.by_name(permitted_params[:defendantName])
             .by_date_of_next_hearing(permitted_params[:dateOfNextHearing])
  end

  def permitted_params
    params.permit(:prosecutionCaseReference,
                  :defendantNINO,
                  :defendantASN,
                  :defendantDOB,
                  :dateOfNextHearing,
                  :defendantName)
  end

  def register_dependant_schemas!
    # Since apiCourtsDefinitions.json does not map to the expected directory structure for both the api responses and the model schemas,
    # we are overriding the id, to ensure that the validator can find the definitions without blowing up.
    courts_definitions = JSON.parse(File.open(Rails.root.join('lib/schemas/global/apiCourtsDefinitions.json')).read)
    courts_definitions['id'] = 'http://justice.gov.uk/unified_search_query/external/global/apicourtsDefinitions.json'
    JSON::Validator.add_schema(JSON::Schema.new(courts_definitions, Addressable::URI.parse(courts_definitions['id'])))
    courts_definitions['id'] = 'http://justice.gov.uk/unified_search_query/external/global/apiCourtsDefinitions.json'
    JSON::Validator.add_schema(JSON::Schema.new(courts_definitions, Addressable::URI.parse(courts_definitions['id'])))
  end
end
