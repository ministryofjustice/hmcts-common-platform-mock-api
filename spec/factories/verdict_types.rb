# frozen_string_literal: true

FactoryBot.define do
  factory :verdict_type do
    add_attribute(:sequence) { 1 }
    description { "Guilty" }
    category { "Guilty" }
    categoryType { "GUILTY" }
    cjs_verdict_code { "324300128" }
    verdict_code { "719478760" }

    factory :realistic_verdict_type do
      add_attribute(:sequence) { Faker::Number.positive.to_i }
      description { Faker::Lorem.sentence }
      category { Faker::Commerce.department }
      categoryType { "GUILTY" }
      cjs_verdict_code { Faker::Code.sin }
      verdict_code { Faker::Code.sin }
    end
  end
end
