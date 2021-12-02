# frozen_string_literal: true

FactoryBot.define do
  factory :hearing_day do
    sittingDay { "2019-10-23 16:19:15" }
    listingSequence { 1 }
    listedDurationMinutes { 120 }
    courtRoomId { "f866cbff-313a-4a0f-86a8-9d66768ba072" }
    isCancelled { false }
    court_centre_id { "6131bd34-33d9-3d1e-8152-8b5a2084f1bd" }
  end

  factory :realistic_hearing_day, class: "HearingDay" do
    sittingDay { Faker::Date.forward(days: 23) }
    listingSequence { Faker::Number.number(digits: 1) }
    listedDurationMinutes { Faker::Number.number(digits: 3) }
    courtRoomId { SecureRandom.uuid }
    isCancelled { Faker::Boolean.boolean }
    court_centre_id { CourtCentre.all.sample.id }
  end
end
