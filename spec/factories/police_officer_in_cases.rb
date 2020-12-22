# frozen_string_literal: true

FactoryBot.define do
  factory :police_officer_in_case do
    person
    policeOfficerRank { "Captain" }
    policeWorkerReferenceNumber { "4233223423" }
    policeWorkerLocationCode { "AK" }

    factory :realistic_police_officer_in_case do
      association :person, factory: :realistic_person
      policeOfficerRank { Faker::Military.army_rank }
      policeWorkerReferenceNumber { Faker::Alphanumeric.alphanumeric(number: 10) }
      policeWorkerLocationCode { Faker::Alphanumeric.alpha(number: 2) }
    end
  end
end
