# frozen_string_literal: true

FactoryBot.define do
  factory :hearing_day do
    sittingDay { "2019-10-23 16:19:15" }
    listingSequence { 1 }
    listedDurationMinutes { 1 }
  end

  factory :realistic_hearing_day, class: "HearingDay" do
    sittingDay { Faker::Date.forward(days: 23) }
    listingSequence { Faker::Number.number(digits: 1) }
    listedDurationMinutes { Faker::Number.number(digits: 3) }
  end
end
