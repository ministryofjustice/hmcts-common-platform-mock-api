FactoryBot.define do
  factory :future_summons_hearing do
    jurisdiction_type { "CROWN" }
    earliest_start_date_time { "2021-07-12T00:00:00+00:00" }
    week_commencing_date { { startDate: "2021-05-01", duration: 1 } }
    estimated_minutes { 1 }
    court_centre_id { CourtCentre.all.sample.id }

    after(:build) do |court_hearing_request|
      court_hearing_request.judicial_roles << build(:judicial_role)
    end

    factory :realistic_future_summons_hearing do
      jurisdiction_type { CourtHearingRequest::JURISDICTION_TYPES.sample }
      earliest_start_date_time { Faker::Date.forward.rfc3339 }
      week_commencing_date { { start_date: "2021-05-01", duration: 1 } }
      estimated_minutes { 1 }
      court_centre_id { CourtCentre.all.sample.id }

      after(:build) do |court_hearing_request|
        court_hearing_request.judicial_roles << build(:judicial_role)
      end
    end
  end
end
