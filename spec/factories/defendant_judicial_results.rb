# frozen_string_literal: true

FactoryBot.define do
  factory :defendant_judicial_result do
    masterDefendantId { SecureRandom.uuid }
    judicial_result
    factory :realistic_defendant_judicial_result do
      association :judicial_result, factory: :realistic_judicial_result
    end
  end
end
