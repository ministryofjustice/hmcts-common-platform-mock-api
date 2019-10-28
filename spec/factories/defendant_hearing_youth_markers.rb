# frozen_string_literal: true

FactoryBot.define do
  factory :defendant_hearing_youth_marker do
    prosecution_case
    defendant
    hearing
    marker
  end
end
