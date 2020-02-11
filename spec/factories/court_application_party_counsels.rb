# frozen_string_literal: true

FactoryBot.define do
  factory :court_application_party_counsel do
    applicationId { SecureRandom.uuid }
    title { 'Mr' }
    firstName { 'John' }
    middleName { 'Random' }
    lastName { 'Rob' }
    status { 'Random' }
    after(:build) do |applicant_counsel|
      applicant_counsel.attendance_days << build(:attendance_day)
    end
  end
end
