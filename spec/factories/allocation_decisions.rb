FactoryBot.define do
  factory :allocation_decision do
    originatingHearingId { SecureRandom.uuid }
    offenceId { SecureRandom.uuid }
    motReasonId { SecureRandom.uuid }
    motReasonDescription { "This is a description" }
    motReasonCode { 1 }
    allocationDecisionDate { "2019-10-14 13:46:12" }
    isSection22ALowValueShoplifting { false }
    isDamageValueUnder5000 { false }
    isTreatedAsIndictableOnly { false }
    sentencingIndicationRequested { false }
    court_indicated_sentence
  end
end
