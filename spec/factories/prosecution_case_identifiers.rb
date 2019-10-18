# frozen_string_literal: true

FactoryBot.define do
  factory :prosecution_case_identifier do
    caseURN { '3658e889-e050-4608-8f21-8bdaa529f8d0' }
    prosecutionAuthorityReference { 'S5589083H' }
    prosecutionAuthorityId { '91c0e6c7-4a4f-415b-a3e1-aea9883f6065' }
    prosecutionAuthorityCode { 'S5589083J' }
  end
end
