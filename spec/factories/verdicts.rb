# frozen_string_literal: true

FactoryBot.define do
  has_jurors = Faker::Boolean.boolean
  has_lesser_or_alternative_offence = Faker::Boolean.boolean
  factory :verdict do
    hearing
    offence
    application_id { "7b76776d-ca00-44c9-ac98-fbba9c8f721a" }
    verdictDate { "2019-10-14 16:18:56" }
    verdict_type

    factory :verdict_with_relationships do
      jurors
      lesser_or_alternative_offence
    end

    factory :realistic_verdict do
      has_jurors = true
      has_lesser_or_alternative_offence = true
      association :hearing, factory: :realistic_hearing
      association :offence, factory: :realistic_offence
      application_id { SecureRandom.uuid }
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
