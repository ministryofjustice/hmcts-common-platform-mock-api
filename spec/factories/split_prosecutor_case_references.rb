# frozen_string_literal: true

FactoryBot.define do
  factory :split_prosecutor_case_reference do
    split { 'MyString' }
    factory :realistic_split_prosecutor_case_reference do
      split { Faker::Hipster.word }
    end
  end
end
