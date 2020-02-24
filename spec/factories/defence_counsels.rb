# frozen_string_literal: true

FactoryBot.define do
  factory :defence_counsel do
    title { 'Mr' }
    firstName { 'John' }
    middleName { 'Random' }
    lastName { 'Rob' }
    status { 'Random' }
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
    status { Faker::Demographic.race }
    after(:build) do |defence_counsel|
      defence_counsel.defendants << build(:realistic_defendant)
      defence_counsel.attendance_days << build(:realistic_attendance_day)
    end
  end
end
