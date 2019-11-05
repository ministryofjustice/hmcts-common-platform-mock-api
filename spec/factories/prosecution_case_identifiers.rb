# frozen_string_literal: true

FactoryBot.define do
  factory :prosecution_case_identifier do
    caseURN { '3658e889-e050-4608-8f21-8bdaa529f8d0' }
    prosecutionAuthorityId { '91c0e6c7-4a4f-415b-a3e1-aea9883f6065' }
    prosecutionAuthorityCode { 'S5589083J' }
    factory :prosecution_case_identifier_with_reference do
      caseURN { nil }
      prosecutionAuthorityReference { 'S5589083J' }
    end

    factory :random_prosecution_case_identifier do
      transient do
        has_case_urn { [true, false].sample }
      end

      prosecutionAuthorityId { SecureRandom.uuid }
      prosecutionAuthorityCode { Faker::Alphanumeric.alpha(number: 10).upcase }
      caseURN { has_case_urn ? SecureRandom.uuid : nil }
      prosecutionAuthorityReference { has_case_urn ? nil : Faker::Alphanumeric.alpha(number: 10).upcase }
    end
  end
end
