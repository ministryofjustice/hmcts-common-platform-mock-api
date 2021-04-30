# frozen_string_literal: true

FactoryBot.define do
  factory :prosecution_case_identifier do
    caseURN { "INHRBICZKQ" }
    prosecutionAuthorityId { "91c0e6c7-4a4f-415b-a3e1-aea9883f6065" }
    prosecutionAuthorityCode { "S5589083J" }
    prosecution_authority_name { "MyString" }
    prosecution_authority_oucode { "12345" }
    major_creditor_code { "6789" }
    address
    contact_number
    factory :prosecution_case_identifier_with_reference do
      caseURN { nil }
      prosecutionAuthorityReference { "S5589083J" }
    end

    factory :realistic_prosecution_case_identifier do
      prosecutionAuthorityId { SecureRandom.uuid }
      prosecutionAuthorityCode { Faker::Alphanumeric.alpha(number: 10).upcase }
      caseURN { Faker::Alphanumeric.alpha(number: 10).upcase }
      prosecutionAuthorityReference { nil }
      prosecution_authority_name { Faker::Lorem.word }
      prosecution_authority_oucode { Faker::Number.number(digits: 4) }
      major_creditor_code { Faker::Number.number(digits: 4) }
      address { association :realistic_address }
      contact_number { association :realistic_contact_number }
    end
  end
end
