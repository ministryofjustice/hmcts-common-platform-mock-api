FactoryBot.define do
  factory :prosecution_case_identifier do
    caseURN { SecureRandom.uuid }
    prosecutionAuthorityReference { 'S5589083H' }
    prosecutionAuthorityId { SecureRandom.uuid }
    prosecutionAuthorityCode { 'S5589083J' }
  end
end
