# frozen_string_literal: true

# set up schema matchers

# rubocop:disable Metrics/BlockLength
RSpec.configure do |config|
  config.include JSON::SchemaMatchers

  # Models
  config.json_schemas[:address] = 'spec/support/schemas/global/address.json'
  config.json_schemas[:allocation_decision] = 'spec/support/schemas/global/allocationDecision.json'
  config.json_schemas[:applicant_counsel] = 'spec/support/schemas/global/applicantCounsel.json'
  config.json_schemas[:associated_defence_organisation] = 'spec/support/schemas/global/associatedDefenceOrganisation.json'
  config.json_schemas[:associated_person] = 'spec/support/schemas/global/associatedPerson.json'
  config.json_schemas[:attendance_day] = 'spec/support/schemas/global/attendanceDay.json'
  config.json_schemas[:bail_status] = 'spec/support/schemas/global/bailStatus.json'
  config.json_schemas[:contact_number] = 'spec/support/schemas/global/contactNumber.json'
  config.json_schemas[:court_application_outcome] = 'spec/support/schemas/global/courtApplicationOutcome.json'
  config.json_schemas[:court_application_outcome_type] = 'spec/support/schemas/global/courtApplicationOutcomeType.json'
  config.json_schemas[:court_application_party] = 'spec/support/schemas/global/courtApplicationParty.json'
  config.json_schemas[:court_application_payment] = 'spec/support/schemas/global/courtApplicationPayment.json'
  config.json_schemas[:court_application_type] = 'spec/support/schemas/global/courtApplicationType.json'
  config.json_schemas[:court_centre] = 'spec/support/schemas/global/courtCentre.json'
  config.json_schemas[:court_indicated_sentence] = 'spec/support/schemas/global/courtIndicatedSentence.json'
  config.json_schemas[:custody_time_limit] = 'spec/support/schemas/global/custodyTimeLimit.json'
  config.json_schemas[:defendant] = 'spec/support/schemas/global/defendant.json'
  config.json_schemas[:defendant_alias] = 'spec/support/schemas/global/defendantAlias.json'
  config.json_schemas[:delegated_powers] = 'spec/support/schemas/global/delegatedPowers.json'
  config.json_schemas[:ethnicity] = 'spec/support/schemas/global/ethnicity.json'
  config.json_schemas[:hearing_case_note] = 'spec/support/schemas/global/hearingCaseNote.json'
  config.json_schemas[:hearing_day] = 'spec/support/schemas/global/hearingDay.json'
  config.json_schemas[:hearing_type] = 'spec/support/schemas/global/hearingType.json'
  config.json_schemas[:indicated_plea] = 'spec/support/schemas/global/indicatedPlea.json'
  config.json_schemas[:judicial_result] = 'spec/support/schemas/global/judicialResult.json'
  config.json_schemas[:judicial_result_prompt] = 'spec/support/schemas/global/judicialResultPrompt.json'
  config.json_schemas[:judicial_result_prompt_duration_element] = 'spec/support/schemas/global/judicialResultPromptDurationElement.json'
  config.json_schemas[:judicial_role] = 'spec/support/schemas/global/judicialRole.json'
  config.json_schemas[:judicial_role_type] = 'spec/support/schemas/global/judicialRoleType.json'
  config.json_schemas[:jurors] = 'spec/support/schemas/global/jurors.json'
  config.json_schemas[:laa_reference] = 'spec/support/schemas/global/laaReference.json'
  config.json_schemas[:legal_entity_defendant] = 'spec/support/schemas/global/legalEntityDefendant.json'
  config.json_schemas[:lesser_or_alternative_offence] = 'spec/support/schemas/global/lesserOrAlternativeOffence.json'
  config.json_schemas[:linked_defendant] = 'spec/support/schemas/global/linkedDefendant.json'
  config.json_schemas[:marker] = 'spec/support/schemas/global/marker.json'
  config.json_schemas[:merged_prosecution_case] = 'spec/support/schemas/global/mergedProsecutionCase.json'
  config.json_schemas[:merged_prosecution_case_target] = 'spec/support/schemas/global/mergedProsecutionCaseTarget.json'
  config.json_schemas[:next_hearing] = 'spec/support/schemas/global/nextHearing.json'
  config.json_schemas[:next_hearing_defendant] = 'spec/support/schemas/global/nextHearingDefendant.json'
  config.json_schemas[:next_hearing_offence] = 'spec/support/schemas/global/nextHearingOffence.json'
  config.json_schemas[:next_hearing_prosecution_case] = 'spec/support/schemas/global/nextHearingProsecutionCase.json'
  config.json_schemas[:notified_plea] = 'spec/support/schemas/global/notifiedPlea.json'
  config.json_schemas[:offence] = 'spec/support/schemas/global/offence.json'
  config.json_schemas[:offence_facts] = 'spec/support/schemas/global/offenceFacts.json'
  config.json_schemas[:organisation] = 'spec/support/schemas/global/organisation.json'
  config.json_schemas[:person] = 'spec/support/schemas/global/person.json'
  config.json_schemas[:person_defendant] = 'spec/support/schemas/global/personDefendant.json'
  config.json_schemas[:plea] = 'spec/support/schemas/global/plea.json'
  config.json_schemas[:police_officer_in_case] = 'spec/support/schemas/global/policeOfficerInCase.json'
  config.json_schemas[:prosecuting_authority] = 'spec/support/schemas/global/prosecutingAuthority.json'
  config.json_schemas[:prosecution_case] = 'spec/support/schemas/global/prosecutionCase.json'
  config.json_schemas[:prosecution_case_identifier] = 'spec/support/schemas/global/prosecutionCaseIdentifier.json'
  config.json_schemas[:referral_reason] = 'spec/support/schemas/global/referralReason.json'
  config.json_schemas[:verdict] = 'spec/support/schemas/global/verdict.json'
  config.json_schemas[:verdict_type] = 'spec/support/schemas/global/verdictType.json'

  # Search
  config.json_schemas[:offence_summary] = 'spec/support/schemas/global/search/offenceSummary.json'
  config.json_schemas[:prosecution_case_summary] = 'spec/support/schemas/global/search/prosecutionCaseSummary.json'

  # Responses
  config.json_schemas[:search_prosecution_case_response] = 'spec/support/schemas/api/search-prosecutionCaseResponse.json'
end
# rubocop:enable Metrics/BlockLength
