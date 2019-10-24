# frozen_string_literal: true

FactoryBot.define do
  factory :defendant_hearing_youth_marker do
    prosecution_case
    defendant
    hearing_id { SecureRandom.uuid }
    marker
  end
end
