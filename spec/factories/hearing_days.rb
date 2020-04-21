# frozen_string_literal: true

FactoryBot.define do
  factory :hearing_day do
    sittingDay { '2019-10-23 16:19:15' }
    listingSequence { 1 }
    listedDurationMinutes { 1 }

    factory :hearing_day_with_relationships do
      startTime { '10:00' }
      endTime { '12:00' }
      onTheDayCourtRoomId { SecureRandom.uuid }
      court_centre
      after(:build) do |hearing_day|
        hearing_day.judicial_roles << build(:judicial_role)
      end
    end
  end
end
