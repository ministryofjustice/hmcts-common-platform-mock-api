# frozen_string_literal: true

FactoryBot.define do
  factory :indicated_plea do
    hearing
    offence
    indicatedPleaDate { '2019-10-14' }
    indicatedPleaValue { 'NO_INDICATION' }
    source { 'ONLINE' }

    factory :realistic_indicated_plea do
      association :hearing, factory: :realistic_hearing
      association :offence, factory: :realistic_offence
      indicatedPleaDate { Date.today - Faker::Number.number(digits: 3).to_i.days }
      indicatedPleaValue { IndicatedPlea::VALUES.sample }
      source { IndicatedPlea::SOURCES.sample }
    end
  end
end
