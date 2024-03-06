# frozen_string_literal: true

module DemoDataHelper
  SQL = "INNER JOIN defendants ON defendants.prosecution_case_id = prosecution_cases.id INNER JOIN person_defendants ON person_defendants.id = defendants.defendable_id AND defendants.defendable_type = 'PersonDefendant'"
  def prosecution_cases_by_reference(urn)
    ProsecutionCase
      .joins(:prosecution_case_identifier)
      .where('"caseURN" = :search OR "prosecutionAuthorityReference" = :search', search: urn)
  end

  def prosecution_cases_by_nino(nino)
    ProsecutionCase
      .joins(SQL)
      .merge(
        PersonDefendant
          .joins(:person)
          .where(people: { nationalInsuranceNumber: nino }),
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

  def case_details_hash(urn)
    pc = prosecution_cases_by_reference(urn).first

    case_details = defendant_offence_details_for(pc)
    case_details << cracked_ineffective_trial_sentences_for(pc)
  end

  def defendant_offence_details_for(prosecution_case)
    prosecution_case.defendants.map { |defendant|
      defendant.offences.map do |offence|
        {
          defendant_id: defendant.id,
          defendant_name: "#{defendant.defendable.person.firstName} #{defendant.defendable.person.lastName}",
          offence_id: offence.id,
          offence_desc: offence.offenceTitle,
          mode_of_trial: offence.modeOfTrial,
          mot_reasons: offence.allocation_decisions.map(&:motReasonDescription),
          plea_sentences: offence.pleas.map { |p| "#{p.pleaValue} on #{p.pleaDate}" },
        }
      end
    }.flatten
  end

  def cracked_ineffective_trial_sentences_for(prosecution_case)
    cracked_ineffective_trial_sentences = prosecution_case.hearings.map do |hearing|
      "#{hearing.cracked_ineffective_trial&.reason_type} because #{hearing.cracked_ineffective_trial&.description}" \
        if hearing.cracked_ineffective_trial
    end

    { cracked_ineffective_trial_sentences: }
  end
end
