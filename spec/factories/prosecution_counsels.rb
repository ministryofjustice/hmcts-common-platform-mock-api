# frozen_string_literal: true

FactoryBot.define do
  factory :prosecution_counsel do
    title { 'Mr' }
    firstName { 'John' }
    middleName { 'Random' }
    lastName { 'Rob' }
    status { 'Random' }
    after(:build) do |prosecution_counsel|
      prosecution_counsel.prosecution_cases << build(:prosecution_case)
      prosecution_counsel.attendance_days << build(:attendance_day)
    end
  end
end
