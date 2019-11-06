# frozen_string_literal: true

FactoryBot.define do
  factory :verdict_type do
    add_attribute(:sequence) { 1 }
    description { 'MyString' }
    category { 'MyString' }
    categoryType { 'MyString' }

    factory :realistic_verdict_type do
      add_attribute(:sequence) { Faker::Number.positive.to_i }
      description { Faker::Lorem.sentence }
      category { Faker::Commerce.department }
      categoryType { Faker::Commerce.material }
    end
  end
end
