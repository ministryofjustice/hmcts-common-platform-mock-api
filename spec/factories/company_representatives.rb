# frozen_string_literal: true

FactoryBot.define do
  factory :company_representative do
    title { 'MR' }
    firstName { 'Alicia' }
    lastName { 'Goodwin' }
    position { 'SECRETARY' }
    after(:build) do |company_representative|
      company_representative.defendants << FactoryBot.create(:defendant)
      company_representative.attendance_days << FactoryBot.create(:attendance_day)
    end
  end

  factory :realistic_company_representative, class: 'CompanyRepresentative' do
    title { Person::TITLES.sample }
    firstName { Faker::Name.first_name }
    lastName { Faker::Name.last_name }
    position { CompanyRepresentative::POSITIONS.sample }
    after(:build) do |company_representative|
      company_representative.defendants << FactoryBot.create(:realistic_defendant)
      company_representative.attendance_days << FactoryBot.create(:realistic_attendance_day)
    end
  end
end
