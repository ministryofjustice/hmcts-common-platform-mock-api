# frozen_string_literal: true

FactoryBot.define do
  factory :allocation_decision do
    hearing
    offence
    motReasonId { SecureRandom.uuid }
    motReasonDescription { "Indictable-only offence" }
    motReasonCode { "2" }
    sequenceNumber { 1 }
    allocationDecisionDate { "2019-10-14 13:46:12" }
    isSection22ALowValueShoplifting { false }
    isDamageValueUnder5000 { false }
    isTreatedAsIndictableOnly { false }
    sentencingIndicationRequested { false }

    factory :allocation_decision_with_relationships do
      court_indicated_sentence
    end

    factory :realistic_allocation_decision do
      association :hearing, factory: :realistic_hearing
      association :offence, factory: :realistic_offence
      motReasonId { SecureRandom.uuid }
      motReasonDescription { "Indictable-only offence" }
      motReasonCode { "2" }
      sequenceNumber { Faker::Number.number(digits: 3) }
      allocationDecisionDate { Faker::Date.backward }
      isSection22ALowValueShoplifting { Faker::Boolean.boolean }
      isDamageValueUnder5000 { Faker::Boolean.boolean }
      isTreatedAsIndictableOnly { Faker::Boolean.boolean }
      sentencingIndicationRequested { Faker::Boolean.boolean }
      association :court_indicated_sentence, factory: :realistic_court_indicated_sentence
    end
  end
end
