# frozen_string_literal: true

FactoryBot.define do
  factory :attendance_day do
    day { '2019-10-24 11:07:20' }
    isInAttendance { false }
  end
end
