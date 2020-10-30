# frozen_string_literal: true

FactoryBot.define do
  factory :defence_counsel do
    title { Faker::Name.prefix }
    firstName { Faker::Name.first_name }
    middleName { Faker::Name.first_name }
    lastName { Faker::Name.last_name }
    status { 'Junior counsel' }

    after(:build) do |defence_counsel|
      defence_counsel.defendants << build(:defendant)
      defence_counsel.attendance_days << build(:attendance_day)
    end
  end

  factory :realistic_defence_counsel, class: 'DefenceCounsel' do
    title { Person::TITLES.sample }
    firstName { Faker::Name.first_name }
    middleName { Faker::Name.middle_name }
    lastName { Faker::Name.last_name }
    status { "#{Faker::Job.seniority} counsel" }
    after(:build) do |defence_counsel|
      defence_counsel.defendants << build(:realistic_defendant)
      defence_counsel.attendance_days << build(:realistic_attendance_day)
    end
  end
end
