# frozen_string_literal: true

module DemoDataHelper
  def prosecution_cases_by_reference(urn)
    ProsecutionCase
      .joins(:prosecution_case_identifier)
      .where('"caseURN" = :search OR "prosecutionAuthorityReference" = :search', search: urn)
  end

  def prosecution_cases_by_nino(nino)
    ProsecutionCase
      .joins(person_only_defendants: :person_defendant)
      .merge(
        PersonDefendant
          .joins(:person)
          .where(people: { nationalInsuranceNumber: nino })
      )
  end

  def humanize_defended_item(defended_item)
    if defended_item.respond_to?(:organisation)
      "Org: #{defended_item.organisation.name}"
    else
      "Person: #{defended_item.person.firstName}, #{defended_item.person.lastName}, #{defended_item.person&.nationalInsuranceNumber}"
    end
  end

  def humanize_prosecution_case(pcase)
    pcase.prosecution_case_identifier.caseURN || pcase.prosecution_case_identifier.prosecutionAuthorityReference
  end
end