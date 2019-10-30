# frozen_string_literal: true

FactoryBot.define do
  factory :hearing_case_note do
    hearing
    association :court_clerk, factory: :delegated_powers
    noteDateTime { '2019-10-23 11:32:36' }
    noteType { 'HMCTS' }
    note { 'Random' }
    after(:build) do |hearing_case_note|
      hearing_case_note.prosecution_cases << FactoryBot.build(:prosecution_case)
    end
  end
end
