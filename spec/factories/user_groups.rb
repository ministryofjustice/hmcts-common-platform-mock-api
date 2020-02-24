# frozen_string_literal: true

FactoryBot.define do
  factory :user_group do
    group { 'General Systems Vehicle' }
    factory :realistic_user_group do
      group { Faker::Commerce.department }
    end
  end
end
