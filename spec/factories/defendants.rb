FactoryBot.define do
  factory :defendant do
    prosecutionCaseId { SecureRandom.uuid }
    numberOfPreviousConvictionsCited { 1 }
    prosecutionAuthorityReference { "MyString" }
    witnessStatement { "MyString" }
    witnessStatementWelsh { "MyString" }
    mitigation { "MyString" }
    mitigationWelsh { "MyString" }
    association :defendable, factory: :person_defendant
    croNumber { "MyString" }
    pncId { "MyString" }
    mergedProsecutionCaseReference { "MyString" }
    factory :defendant_as_legal_entity do
        association :defendable, factory: :legal_entity_defendant
    end
    after(:build) do |defendant|
        defendant.offences << FactoryBot.build(:offence, defendant: nil)
    end
  end
end
