# frozen_string_literal: true

FactoryBot.define do
  factory :offence_facts do
    vehicleRegistration { 'Random String' }
    alcoholReadingAmount { 1 }
    alcoholReadingMethodCode { 'Random String' }
    alcoholReadingMethodDescription { 'Random String' }
    vehicleCode { 'PASSENGER_CARRYING_VEHICLE' }
  end
end
