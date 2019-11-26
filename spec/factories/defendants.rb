# frozen_string_literal: true

FactoryBot.define do
  factory :defendant do
    trait :with_next_hearing do
      transient do
        next_hearing_date { '2025-05-04' }
      end
      after(:build) do |defendant, evaluator|
        next_hearing = FactoryBot.build(:next_hearing, listedStartDateTime: evaluator.next_hearing_date)
        defendant.judicial_results << FactoryBot.build(:judicial_result,
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
      defendant.offences << FactoryBot.build(:offence, defendant: nil)
    end
  end
end
