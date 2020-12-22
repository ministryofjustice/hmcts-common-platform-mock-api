# frozen_string_literal: true

FactoryBot.define do
  factory :plea do
    hearing
    offence
    pleaDate { "2019-10-14 14:59:41" }
    pleaValue { Plea::VALUES.sample }

    factory :plea_with_relationships do
      delegated_powers
    end

    factory :realistic_plea do
      association :hearing, factory: :realistic_hearing
      association :offence, factory: :realistic_offence
      pleaDate { Faker::Date.backward }
      pleaValue { Plea::VALUES.sample }
    end
  end
end
