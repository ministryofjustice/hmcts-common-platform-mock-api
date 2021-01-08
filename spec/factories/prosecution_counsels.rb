# frozen_string_literal: true

FactoryBot.define do
  factory :prosecution_counsel do
    title { Faker::Name.prefix }
    firstName { Faker::Name.first_name }
    middleName { Faker::Name.first_name }
    lastName { Faker::Name.last_name }
    status { "Prosecution counsel status" }
    after(:build) do |prosecution_counsel|
      prosecution_counsel.prosecution_cases << build(:prosecution_case)
      prosecution_counsel.attendance_days << build(:attendance_day)
    end
  end
end
