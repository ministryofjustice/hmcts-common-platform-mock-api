# set up schema matchers
RSpec.configure do |config|
  config.include JSON::SchemaMatchers
  config.json_schemas[:address] = 'spec/support/schemas/address.json'
  config.json_schemas[:contact_number] = 'spec/support/schemas/contactNumber.json'
  config.json_schemas[:ethnicity] = 'spec/support/schemas/ethnicity.json'
  config.json_schemas[:indicated_plea] = 'spec/support/schemas/indicatedPlea.json'
  config.json_schemas[:notified_plea] = 'spec/support/schemas/notifiedPlea.json'
  config.json_schemas[:person] = 'spec/support/schemas/person.json'
  config.json_schemas[:police_officer_in_case] = 'spec/support/schemas/policeOfficerInCase.json'
  config.json_schemas[:prosecution_case_identifier] = 'spec/support/schemas/prosecutionCaseIdentifier.json'
  config.json_schemas[:court_indicated_sentence] = 'spec/support/schemas/courtIndicatedSentence.json'
  config.json_schemas[:allocation_decision] = 'spec/support/schemas/allocationDecision.json'
  config.json_schemas[:delegated_powers] = 'spec/support/schemas/delegatedPowers.json'
  config.json_schemas[:plea] = 'spec/support/schemas/plea.json'
  config.json_schemas[:verdict_type] = 'spec/support/schemas/verdictType.json'
  config.json_schemas[:jurors] = 'spec/support/schemas/jurors.json'
  config.json_schemas[:lesser_or_alternative_offence] = 'spec/support/schemas/lesserOrAlternativeOffence.json'
  config.json_schemas[:offence_facts] = 'spec/support/schemas/offenceFacts.json'
  config.json_schemas[:verdict] = 'spec/support/schemas/verdict.json'
  config.json_schemas[:hearing_type] = 'spec/support/schemas/hearingType.json'
  config.json_schemas[:judicial_role_type] = 'spec/support/schemas/judicialRoleType.json'
  config.json_schemas[:court_centre] = 'spec/support/schemas/courtCentre.json'
end
