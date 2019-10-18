# frozen_string_literal: true

FactoryBot.define do
  factory :next_hearing_defendant do
    after(:build) do |next_hearing_defendant|
      next_hearing_defendant.next_hearing_offences << FactoryBot.build(:next_hearing_offence, next_hearing_defendant: nil)
    end
  end
end
