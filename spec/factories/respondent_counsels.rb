# frozen_string_literal: true

FactoryBot.define do
  factory :respondent_counsel do
    title { 'Mr' }
    firstName { 'John' }
    middleName { 'Random' }
    lastName { 'Rob' }
    status { 'Random' }
    after(:build) do |defence_counsel|
      defence_counsel.court_application_respondents << FactoryBot.build(:court_application_respondent)
      defence_counsel.attendance_days << FactoryBot.build(:attendance_day)
    end
  end
end
