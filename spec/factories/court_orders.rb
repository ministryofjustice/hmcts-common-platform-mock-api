FactoryBot.define do
  factory :court_order do
    id { "bd73444f-cd60-4141-8b91-1ad91ef78497" }
    defendant_ids { %w[426c29d6-66b1-4137-b93e-3ae23fdc60a5] }
    master_defendant_id { "3592dd86-2f41-4f7d-bd05-ce2cf1904262" }
    judicial_result_type_id { "b492eb27-6800-4204-a861-8ea08a0fc4cc" }
    label { "quis" }
    order_date { "2021-03-01" }
    start_date { "2021-03-01" }
    end_date { "2022-03-01" }
    court_centre_id { "6131bd34-33d9-3d1e-8152-8b5a2084f1bd" }
    ordering_hearing_id { "d9ddeb65-eb0c-4d09-baf1-5052a93fefaa" }
    is_sjp_order { true }
    can_be_subject_of_breach_proceedings { true }
    can_be_subject_of_variation_proceedings { true }

    after(:build) do |court_order|
      court_order.court_order_offences << build(:court_order_offence)
    end

    factory :realistic_court_order do
      id { SecureRandom.uuid }
      defendant_ids { [SecureRandom.uuid] }
      master_defendant_id { SecureRandom.uuid }
      judicial_result_type_id { SecureRandom.uuid }
      label { Faker::Lorem.word }
      order_date { Faker::Date.backward }
      start_date { Faker::Date.backward }
      end_date { Faker::Date.forward }
      court_centre_id { "6131bd34-33d9-3d1e-8152-8b5a2084f1bd" }
      ordering_hearing_id { SecureRandom.uuid }
      is_sjp_order { Faker::Boolean.boolean }
      can_be_subject_of_breach_proceedings { Faker::Boolean.boolean }
      can_be_subject_of_variation_proceedings { Faker::Boolean.boolean }

      after(:build) do |court_order|
        court_order.court_order_offences << build(:court_order_offence)
      end
    end
  end
end
