# frozen_string_literal: true

FactoryBot.define do
  factory :judicial_result_prompt_duration_element do
    primaryDurationUnit { "MyString" }
    primaryDurationValue { 1 }
    primaryLabel { "MyString" }
    secondaryDurationUnit { "MyString" }
    secondaryDurationValue { 1 }
    tertiaryDurationUnit { "MyString" }
    tertiaryDurationValue { 1 }
  end
end
