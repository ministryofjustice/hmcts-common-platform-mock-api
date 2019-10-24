# frozen_string_literal: true

FactoryBot.define do
  factory :applicant_counsel do
    title { 'Mr' }
    firstName { 'John' }
    middleName { 'Random' }
    lastName { 'Rob' }
    status { 'Random' }
    after(:build) do |applicant_counsel|
      applicant_counsel.applicants << FactoryBot.build(:applicant)
      applicant_counsel.attendance_days << FactoryBot.build(:attendance_day)
    end
  end
end
