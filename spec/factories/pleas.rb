# frozen_string_literal: true

FactoryBot.define do
  factory :plea do
    hearing
    offence
    pleaDate { "2019-10-14 14:59:41" }
    pleaValue { Plea::VALUES.sample }
    application_id { "14535fbe-cd2d-454e-929e-a7bdcc1be822" }

    factory :plea_with_relationships do
      delegated_powers
      lesser_or_alternative_offence
    end

    factory :realistic_plea do
      association :hearing, factory: :realistic_hearing
      association :offence, factory: :realistic_offence
      pleaDate { Faker::Date.backward }
      pleaValue { Plea::VALUES.sample }
      application_id { SecureRandom.uuid }
      association :lesser_or_alternative_offence, factory: :realistic_lesser_or_alternative_offence
      association :delegated_powers, factory: :delegated_powers
    end
  end
end
