# frozen_string_literal: true

FactoryBot.define do
  factory :indicated_plea do
    offenceId { SecureRandom.uuid }
    originatingHearingId { SecureRandom.uuid }
    indicatedPleaDate { '2019-10-14' }
    indicatedPleaValue { 'NO_INDICATION' }
    source { 'ONLINE' }

    factory :realistic_indicated_plea do
      offenceId { SecureRandom.uuid }
      originatingHearingId { SecureRandom.uuid }
      indicatedPleaDate { Date.today - Faker::Number.number(digits: 3).to_i.days }
      indicatedPleaValue { IndicatedPlea::VALUES.sample }
      source { IndicatedPlea::SOURCES.sample }
    end
  end
end
