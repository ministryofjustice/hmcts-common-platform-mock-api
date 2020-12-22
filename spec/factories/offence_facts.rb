# frozen_string_literal: true

FactoryBot.define do
  factory :offence_facts do
    vehicleRegistration { "Random String" }
    alcoholReadingAmount { 1 }
    alcoholReadingMethodCode { "Random String" }
    alcoholReadingMethodDescription { "Random String" }
    vehicleCode { "PASSENGER_CARRYING_VEHICLE" }

    factory :realistic_offence_facts do
      vehicleRegistration { Faker::Alphanumeric.alphanumeric(number: 7).upcase }
      alcoholReadingAmount { Faker::Number.between(from: 1, to: 15) }
      alcoholReadingMethodCode { Faker::Alphanumeric.alphanumeric(number: 4).upcase }
      alcoholReadingMethodDescription { Faker::Lorem.sentence }
      vehicleCode { OffenceFacts::VEHICLE_CODES.sample }
    end
  end
end
