# frozen_string_literal: true

FactoryBot.define do
  factory :hearing_day do
    sittingDay { "2019-10-23 16:19:15" }
    listingSequence { 1 }
    listedDurationMinutes { 1 }
  end
end
