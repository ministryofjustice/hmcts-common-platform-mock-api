# frozen_string_literal: true

FactoryBot.define do
  factory :next_hearing_prosecution_case do
    after(:build) do |next_hearing_prosecution_case|
      next_hearing_prosecution_case.next_hearing_defendants << FactoryBot.build(:next_hearing_defendant, next_hearing_prosecution_case: nil)
    end
  end

  factory :next_hearing_prosecution_case, class: 'NextHearingProsecutionCase' do
    after(:build) do |next_hearing_prosecution_case|
      next_hearing_prosecution_case.next_hearing_defendants << FactoryBot.build(:realistic_next_hearing_defendant)
    end
  end
end
