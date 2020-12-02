# frozen_string_literal: true

FactoryBot.define do
  factory :organisation do
    name { 'Bergstrom-Johnson' }
    incorporationNumber { 'Random string' }
    registeredCharityNumber { 'Random string' }

    factory :organisation_with_relationships do
      address
      association :contact, factory: :contact_number
    end

    factory :realistic_organisation do
      name { Faker::Company.name }
      incorporationNumber { Faker::Company.ein }
      registeredCharityNumber { Faker::Company.duns_number }
    end
  end
end
