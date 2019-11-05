# frozen_string_literal: true

FactoryBot.define do
  factory :prosecution_case do
    prosecution_case_identifier
    originatingOrganisation { 'Random String' }
    initiationCode { 'Q' }
    caseStatus { 'INACTIVE' }
    police_officer_in_case { nil }
    statementOfFacts { 'Random String' }
    statementOfFactsWelsh { 'Random String' }
    breachProceedingsPending { false }
    appealProceedingsPending { false }
    merged_prosecution_case { nil }

    after(:build) do |prosecution_case|
      prosecution_case.defendants << FactoryBot.build(:defendant, prosecution_case: nil)
    end

    factory :realistic_prosecution_case do
      association :prosecution_case_identifier, factory: :realistic_prosecution_case_identifier
      originatingOrganisation { Faker::Company.name }
      initiationCode { ProsecutionCase::INITIATION_CODES.sample }
      caseStatus { ProsecutionCase::CASE_STATUSES.sample }
      police_officer_in_case
      statementOfFacts { 'Random String' }
      statementOfFactsWelsh { 'Random String' }
      breachProceedingsPending { false }
      appealProceedingsPending { false }
      merged_prosecution_case { nil }
    end
  end
end
