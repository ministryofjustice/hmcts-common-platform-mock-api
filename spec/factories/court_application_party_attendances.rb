# frozen_string_literal: true

FactoryBot.define do
  factory :court_application_party_attendance do
    court_application_party
    after(:build) do |court_application_party_attendance|
      court_application_party_attendance.attendance_days << FactoryBot.create(:attendance_day)
    end
  end
end
