# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    address1 { "Roob Pike" }
    address2 { "83589 Bartell Groves" }
    address3 { "946" }
    address4 { "Suite 825" }
    address5 { "Apt 922" }
    postcode { "W0T 6JB" }
    factory :realistic_address do
      address1 { Faker::Address.street_address }
      address2 { Faker::Address.secondary_address }
      address3 { Faker::Address.building_number }
      address4 { Faker::Address.city }
      address5 { Faker::Address.country }
      postcode { Faker::Address.postcode.slice(0, 8) }
    end
  end
end
