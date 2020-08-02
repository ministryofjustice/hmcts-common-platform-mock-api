# frozen_string_literal: true

FactoryBot.define do
  factory :hearing_day do
    sittingDay { '2019-10-23 16:19:15' }
    startTime { '2000-01-01 07:30:00' }
    listingSequence { 1 }
    listedDurationMinutes { 1 }
  end
end
