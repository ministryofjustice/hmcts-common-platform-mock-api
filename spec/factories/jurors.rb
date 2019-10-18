# frozen_string_literal: true

FactoryBot.define do
  factory :jurors do
    numberOfJurors { 1 }
    numberOfSplitJurors { 1 }
    unanimous { false }
  end
end
