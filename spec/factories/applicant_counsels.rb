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

  factory :realistic_applicant_counsel, class: 'ApplicantCounsel' do
    title { Person::TITLES.sample }
    firstName { Faker::Name.first_name }
    middleName { Faker::Name.middle_name }
    lastName { Faker::Name.last_name }
    status { Faker::Demographic.race }
    after(:build) do |applicant_counsel|
      applicant_counsel.applicants << FactoryBot.build(:realistic_applicant, applicant_counsel: nil)
      applicant_counsel.attendance_days << FactoryBot.build(:realistic_attendance_day)
    end
  end
end
