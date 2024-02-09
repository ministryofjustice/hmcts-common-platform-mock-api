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
      description { "Guilty" }
      category { "Guilty" }
      categoryType { "GUILTY" }
      cjs_verdict_code { Faker::Code.sin }
      verdict_code { Faker::Code.sin }

      trait :not_guilty do
        description { "Not Guilty" }
        category { "Not Guilty" }
        categoryType { "NOT GUILTY" }
      end
    end
  end
end
