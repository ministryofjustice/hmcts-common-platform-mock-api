# frozen_string_literal: true

FactoryBot.define do
  factory :prosecution_case_hearing do
    prosecution_case
    hearing
  end
end
