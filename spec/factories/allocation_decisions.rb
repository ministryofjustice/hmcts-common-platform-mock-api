# frozen_string_literal: true

FactoryBot.define do
  factory :allocation_decision do
    originatingHearingId { SecureRandom.uuid }
    offenceId { SecureRandom.uuid }
    motReasonId { SecureRandom.uuid }
    motReasonDescription { 'This is a description' }
    motReasonCode { 1 }
    allocationDecisionDate { '2019-10-14 13:46:12' }
    isSection22ALowValueShoplifting { false }
    isDamageValueUnder5000 { false }
    isTreatedAsIndictableOnly { false }
    sentencingIndicationRequested { false }

    factory :realistic_allocation_decision do
      originatingHearingId { SecureRandom.uuid }
      offenceId { SecureRandom.uuid }
      motReasonId { SecureRandom.uuid }
      motReasonDescription { Faker::Lorem.sentence }
      motReasonCode { Faker::Number.number(digits: 3) }
      allocationDecisionDate { Date.today - Faker::Number.number(digits: 3).to_i.days }
      isSection22ALowValueShoplifting { Faker::Boolean.boolean }
      isDamageValueUnder5000 { Faker::Boolean.boolean }
      isTreatedAsIndictableOnly { Faker::Boolean.boolean }
      sentencingIndicationRequested { Faker::Boolean.boolean }
    end
  end
end
