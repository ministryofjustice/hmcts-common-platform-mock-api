# frozen_string_literal: true

FactoryBot.define do
  factory :prosecution_case_hearing_case_note do
    prosecution_case
    hearing_case_note
  end
end
