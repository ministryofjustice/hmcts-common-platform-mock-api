# frozen_string_literal: true

FactoryBot.define do
  factory :verdict do
    originatingHearingId { SecureRandom.uuid }
    offenceId { SecureRandom.uuid }
    verdictDate { '2019-10-14 16:18:56' }
    verdict_type
    factory :realistic_verdict do
      originatingHearingId { SecureRandom.uuid }
      offenceId { SecureRandom.uuid }
      verdictDate { Faker::Date.forward(30) }
      association :verdict_type, factory: :realistic_verdict_type
    end
  end
end
