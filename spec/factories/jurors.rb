# frozen_string_literal: true

FactoryBot.define do
  factory :jurors do
    numberOfJurors { 1 }
    numberOfSplitJurors { 1 }
    unanimous { false }

    factory :realistic_jurors do
      numberOfJurors { Faker::Number.between(1, 12) }
      numberOfSplitJurors { Faker::Number.between(1, 12) }
      unanimous { Faker::Boolean.boolean }
    end
  end
end
