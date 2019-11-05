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
  end

  factory :realistic_prosecution_case, class: 'ProsecutionCase' do
    association :prosecution_case_identifier, factory: :realistic_prosecution_case_identifier
    originatingOrganisation { Faker::Company.name }
    initiationCode { ProsecutionCase::INITIATION_CODES.sample }
    caseStatus { ProsecutionCase::CASE_STATUSES.sample }
    police_officer_in_case
    statementOfFacts { Faker::Hipster.sentence(word_count: 3, supplemental: true, random_words_to_add: 4) }
    statementOfFactsWelsh { Faker::Hipster.sentence(word_count: 3, supplemental: true, random_words_to_add: 4) }
    breachProceedingsPending { [true, false].sample }
    appealProceedingsPending { [true, false].sample }
    association :merged_prosecution_case, factory: :realistic_merged_prosecution_case

    after(:build) do |prosecution_case|
      prosecution_case.defendants << FactoryBot.build(:realistic_defendant, prosecution_case: nil)
      prosecution_case.markers << FactoryBot.build_list(:realistic_marker, (0..3).to_a.sample)
      prosecution_case.split_prosecutor_case_references << FactoryBot.build_list(:realistic_split_prosecutor_case_reference, [0, 2, 3, 4, 5].sample)
      prosecution_case.linked_prosecution_cases << FactoryBot.build_list(:realistic_linked_prosecution_case,
                                                                         (0..3).to_a.sample)
    end
  end
end
