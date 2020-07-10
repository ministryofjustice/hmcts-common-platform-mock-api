# frozen_string_literal: true

FactoryBot.define do
  factory :applicant_counsel do
    title { Faker::Name.prefix }
    firstName { Faker::Name.first_name }
    middleName { Faker::Name.first_name }
    lastName { Faker::Name.last_name }
    status { 'Appplicant counsel status' }
    after(:build) do |applicant_counsel|
      applicant_counsel.applicants << build(:applicant)
      applicant_counsel.attendance_days << build(:attendance_day)
    end
  end

  factory :realistic_applicant_counsel, class: 'ApplicantCounsel' do
    title { Person::TITLES.sample }
    firstName { Faker::Name.first_name }
    middleName { Faker::Name.middle_name }
    lastName { Faker::Name.last_name }
    status { "#{Faker::Job.seniority} counsel" }
    after(:build) do |applicant_counsel|
      applicant_counsel.applicants << build(:realistic_applicant, applicant_counsel: nil)
      applicant_counsel.attendance_days << build(:realistic_attendance_day)
    end
  end
end
