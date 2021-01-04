# frozen_string_literal: true

FactoryBot.define do
  factory :marker do
    markerTypeid { SecureRandom.uuid }
    sequenceNumber { "Random string" }
    markerTypeCode { "Random string" }
    markerTypeLabel { "Random string" }
    markerTypeName { "Random string" }
    splitProsecutorCaseReference { "Random string" }
    factory :realistic_marker do
      markerTypeid { SecureRandom.uuid }
      sequenceNumber { Faker::Alphanumeric.alpha(number: 10).upcase }
      markerTypeCode { Faker::Alphanumeric.alpha(number: 10).upcase }
      markerTypeLabel { Faker::Alphanumeric.alpha(number: 10).upcase }
      markerTypeName { Faker::Lorem.word }
      splitProsecutorCaseReference { Faker::Lorem.word }
    end
  end
end
