FactoryBot.define do
  factory :application_plea do
    originating_hearing_id { "5d4f5ed4-b09e-4b38-b693-45a1bb46eff3" }
    application_id { "cf3d50d3-3111-41cd-bd51-e184291253ce" }
    plea_date { "2019-10-23" }
    plea_value { "MyString" }
    delegated_powers { association :delegated_powers }
    lesser_or_alternative_offence { association :lesser_or_alternative_offence }

    factory :realistic_application_plea do
      originating_hearing_id { SecureRandom.uuid }
      application_id { SecureRandom.uuid }
      plea_date { Faker::Date.backward(days: 14) }
      plea_value { Faker::Lorem.word }
      association :delegated_powers, factory: :realistic_delegated_powers
      association :lesser_or_alternative_offence, factory: :realistic_lesser_or_alternative_offence
    end
  end
end
