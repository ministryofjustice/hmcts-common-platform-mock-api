# frozen_string_literal: true

FactoryBot.define do
  factory :respondent_counsel do
    title { Faker::Name.prefix }
    firstName { Faker::Name.first_name }
    middleName { Faker::Name.first_name }
    lastName { Faker::Name.last_name }
    status { "Respondent counsel status" }
    after(:build) do |defence_counsel|
      defence_counsel.court_application_respondents << build(:court_application_respondent)
      defence_counsel.attendance_days << build(:attendance_day)
    end
  end
end
