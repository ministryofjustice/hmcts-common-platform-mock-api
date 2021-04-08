FactoryBot.define do
  factory :reporting_restriction do
    id { SecureRandom.uuid }
    judicial_result_id { SecureRandom.uuid }
    label { "Absolute discharge" }
    ordered_date { "2019-10-14" }

    factory :realistic_reporting_restriction do
      id { SecureRandom.uuid }
      judicial_result_id { SecureRandom.uuid }
      label { Faker::Lorem.words.join(" ") }
      ordered_date { Faker::Date.backward }
    end
  end
end
