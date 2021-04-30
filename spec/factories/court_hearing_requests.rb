FactoryBot.define do
  factory :court_hearing_request do
    association :hearing_type, factory: :hearing_type
    jurisdiction_type { "CROWN" }
    listed_start_date_time { "2021-07-12T00:00:00+00:00" }
    earliest_start_date_time { "2021-07-12T00:00:00+00:00" }
    end_date { "2021-08-01" }
    booking_reference { "ebc28790-3cde-450f-9290-bc15cb7d6cc5" }
    week_commencing_date { { startDate: "2021-05-01", duration: 1 } }
    estimate_minutes { 1 }
    court_centre_id { "6131bd34-33d9-3d1e-8152-8b5a2084f1bd" }
    listing_directions { "MyString" }

    after(:build) do |court_hearing_request|
      court_hearing_request.rota_slots << build(:rota_slot)
      court_hearing_request.judicial_roles << build(:judicial_role)
    end

    factory :realistic_court_hearing_request do
      association :hearing_type, factory: :hearing_type
      jurisdiction_type { CourtHearingRequest::JURISDICTION_TYPES.sample }
      listed_start_date_time { Faker::Date.forward.rfc3339 }
      earliest_start_date_time { Faker::Date.forward.rfc3339 }
      end_date { Faker::Date.forward.rfc3339 }
      booking_reference { SecureRandom.uuid }
      week_commencing_date { { start_date: "2021-05-01", duration: 1 } }
      estimate_minutes { 1 }
      court_centre_id { "6131bd34-33d9-3d1e-8152-8b5a2084f1bd" }
      listing_directions { "MyString" }

      after(:build) do |court_hearing_request|
        court_hearing_request.rota_slots << build(:rota_slot)
        court_hearing_request.judicial_roles << build(:judicial_role)
      end
    end
  end
end
