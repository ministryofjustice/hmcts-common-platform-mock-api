# frozen_string_literal: true

FactoryBot.define do
  factory :bail_status do
    code { "Random string" }
    description { "Random string" }

    factory :bail_status_with_relationships do
      custody_time_limit
    end

    factory :realistic_bail_status do
      association :custody_time_limit, factory: :realistic_custody_time_limit
      code { Faker::Alphanumeric.alphanumeric(number: 10) }
      description { Faker::Lorem.sentence }
    end
  end
end
