FactoryBot.define do
  factory :reporting_restriction do
    id { "924e81fc-e17e-4f25-b393-b485e76d989d" }
    judicial_result_id { "ae9c9f8d-b63f-4231-a43c-05e87fdc7f10" }
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
