# frozen_string_literal: true

FactoryBot.define do
  factory :attendance_day do
    day { '2019-10-24 11:07:20' }
    isInAttendance { false }

    factory :realistic_attendance_day do
      day { Faker::Date.forward(days: 30) }
      isInAttendance { Faker::Boolean.boolean }
    end
  end
end
