FactoryBot.define do
  factory :company_representative do
    id { "73fc607a-56e5-4b82-9d22-6df17edc370e" }
    title { "Miss" }
    first_name { "Lillian" }
    last_name  { "Fisher" }
    position { "DIRECTOR" }
    defendants { %w[5623a7e4-b3ae-4ffa-8249-91ae54aadc00] }
    attendance_days { %w[2021-04-14] }
    factory :realistic_company_representative do
      id { SecureRandom.uuid }
      title { "Miss" }
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      position { CompanyRepresentative::POSITION.sample }
      defendants { [SecureRandom.uuid] }
      attendance_days { [Faker::Date.forward] }
    end
  end
end
