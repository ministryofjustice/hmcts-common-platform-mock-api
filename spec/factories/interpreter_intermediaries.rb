# frozen_string_literal: true

FactoryBot.define do
  factory :interpreter_intermediary do
    role { 'INTERPRETER' }
    firstName { 'Chin' }
    lastName { 'Kunze' }
    attendant
    after(:build) do |interpreter_intermediary|
      interpreter_intermediary.attendance_days << build(:attendance_day)
    end
  end

  factory :realistic_interpreter_intermediary, class: 'InterpreterIntermediary' do
    role { InterpreterIntermediary::ROLES.sample }
    firstName { 'MyString' }
    lastName { 'MyString' }
    association :attendant, factory: :realistic_attendant
    after(:build) do |interpreter_intermediary|
      interpreter_intermediary.attendance_days << build(:realistic_attendance_day)
    end
  end
end
