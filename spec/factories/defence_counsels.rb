# frozen_string_literal: true

FactoryBot.define do
  factory :defence_counsel do
    title { 'Mr' }
    firstName { 'John' }
    middleName { 'Random' }
    lastName { 'Rob' }
    status { 'Random' }
    after(:build) do |defence_counsel|
      defence_counsel.defendants << FactoryBot.build(:defendant)
      defence_counsel.attendance_days << FactoryBot.build(:attendance_day)
    end
  end
end
