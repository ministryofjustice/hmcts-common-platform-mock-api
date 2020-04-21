# frozen_string_literal: true

FactoryBot.define do
  factory :attendant do
    attendantType { 'WITNESS' }
    name { 'Jimbo' }
    factory :realistic_attendant do
      attendantType { Attendant::ATTENDANT_TYPES.sample }
      name { Faker::Name.name }
      association :defendant, factory: :realistic_defendant
    end
  end
end
