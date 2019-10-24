# frozen_string_literal: true

FactoryBot.define do
  factory :defendant_attendance do
    defendant
    after(:build) do |defendant_attendance|
      defendant_attendance.attendance_days << FactoryBot.create(:attendance_day)
    end
  end
end
