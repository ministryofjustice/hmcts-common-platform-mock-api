# frozen_string_literal: true

FactoryBot.define do
  factory :judicial_result_prompt_duration_element do
    primaryDurationUnit { 'MyString' }
    primaryDurationValue { 1 }
    primaryLabel { 'MyString' }
    secondaryDurationUnit { 'MyString' }
    secondaryDurationValue { 1 }
    tertiaryDurationUnit { 'MyString' }
    tertiaryDurationValue { 'MyString' }
    durationStartDate { '2019-10-15 13:15:32' }
    durationEndDate { '2019-10-15 13:15:32' }
  end
end
