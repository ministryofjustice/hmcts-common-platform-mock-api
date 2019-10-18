# frozen_string_literal: true

FactoryBot.define do
  factory :verdict_type do
    add_attribute(:sequence) { 1 }
    description { 'MyString' }
    category { 'MyString' }
    categoryType { 'MyString' }
  end
end
