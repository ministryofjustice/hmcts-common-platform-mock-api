# frozen_string_literal: true

FactoryBot.define do
  has_jurors = Faker::Boolean.boolean
  has_lesser_or_alternative_offence = Faker::Boolean.boolean
  factory :verdict do
    originatingHearingId { SecureRandom.uuid }
    offenceId { SecureRandom.uuid }
    verdictDate { '2019-10-14 16:18:56' }
    verdict_type

    factory :realistic_verdict do
      originatingHearingId { SecureRandom.uuid }
      offenceId { SecureRandom.uuid }
      verdictDate { Faker::Date.forward(days: 30) }
      association :verdict_type, factory: :realistic_verdict_type
      association :jurors, factory: :realistic_jurors if has_jurors
      if has_lesser_or_alternative_offence
        association :lesser_or_alternative_offence,
                    factory: :realistic_lesser_or_alternative_offence
      end
    end
  end
end
