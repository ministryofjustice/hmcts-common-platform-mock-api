# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
FactoryBot.define do
  factory :defendant do
    trait :with_next_hearing do
      transient do
        next_hearing_date { '2025-05-04' }
      end
      after(:build) do |defendant, evaluator|
        next_hearing = build(:next_hearing, listedStartDateTime: evaluator.next_hearing_date)
        defendant.judicial_results << build(:judicial_result,
                                            next_hearing: next_hearing)
      end
    end
    prosecution_case
    numberOfPreviousConvictionsCited { 1 }
    prosecutionAuthorityReference { 'MyString' }
    witnessStatement { 'MyString' }
    witnessStatementWelsh { 'MyString' }
    mitigation { 'MyString' }
    mitigationWelsh { 'MyString' }
    association :defendable, factory: :person_defendant
    croNumber { 'MyString' }
    pncId { 'MyString' }
    mergedProsecutionCaseReference { 'MyString' }
    factory :defendant_as_legal_entity do
      association :defendable, factory: :legal_entity_defendant
    end
    after(:build) do |defendant|
      defendant.offences << build(:offence, defendant: nil)
    end
  end

  factory :realistic_defendant, class: 'Defendant' do
    association :prosecution_case, factory: :realistic_prosecution_case
    numberOfPreviousConvictionsCited { Faker::Number.positive.to_i }
    prosecutionAuthorityReference { Faker::Lorem.word }
    witnessStatement { Faker::Lorem.paragraph }
    witnessStatementWelsh { Faker::Lorem.paragraph }
    mitigation { Faker::Lorem.paragraph }
    mitigationWelsh { Faker::Lorem.paragraph }
    croNumber { Faker::Code.asin }
    pncId { Faker::Code.rut }
    mergedProsecutionCaseReference { Faker::Lorem.word }

    association :defendable, factory: :realistic_person_defendant
    trait :with_legal_entity_defendant do
      association :defendable, factory: :realistic_legal_entity_defendant
    end

    after(:build) do |defendant|
      defendant.offences << build(:realistic_offence, defendant: nil)
      defendant.associated_people << build_list(:realistic_associated_person,
                                                Faker::Number.between(from: 0, to: 3))
      defendant.defence_organisations << build_list(:realistic_associated_defence_organisation,
                                                    Faker::Number.between(from: 0, to: 3))
      defendant.defendant_aliases << build_list(:realistic_defendant_alias,
                                                Faker::Number.between(from: 0, to: 3))
      defendant.judicial_results << build_list(:realistic_judicial_result,
                                               Faker::Number.between(from: 0, to: 3))
      defendant.markers << build_list(:realistic_marker,
                                      Faker::Number.between(from: 0, to: 3))
      defendant.split_prosecutor_case_references << build_list(:realistic_split_prosecutor_case_reference,
                                                               Faker::Number.between(from: 2, to: 5))
      defendant.linked_defendants << build_list(:realistic_linked_defendant,
                                                Faker::Number.between(from: 0, to: 3))
    end
  end
end
# rubocop:enable Metrics/BlockLength
