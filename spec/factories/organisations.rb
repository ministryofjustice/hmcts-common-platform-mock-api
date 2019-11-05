# frozen_string_literal: true

FactoryBot.define do
  factory :organisation do
    name { 'Random string' }
    incorporationNumber { 'Random string' }
    registeredCharityNumber { 'Random string' }

    factory :realistic_organisation do
      name { Faker::Company.name }
      incorporationNumber { Faker::Company.ein }
      registeredCharityNumber { Faker::Company.duns_number }
    end
  end
end
