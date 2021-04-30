FactoryBot.define do
  factory :committing_court do
    court_centre_id { "6131bd34-33d9-3d1e-8152-8b5a2084f1bd" }
    court_house_type { "CROWN" }
    court_house_code { "DE" }
    court_house_name { "Derby Crown Court" }
    court_house_short_name { "DE" }

    factory :realistic_committing_court do
      court_centre_id { "6131bd34-33d9-3d1e-8152-8b5a2084f1bd" }
      court_house_type { CommittingCourt::COURT_TYPES.sample }
      court_house_code { "DE" }
      court_house_name { "Derby Crown Court" }
      court_house_short_name { "DE" }
    end
  end
end
