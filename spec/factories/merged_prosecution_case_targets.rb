# frozen_string_literal: true

FactoryBot.define do
  factory :merged_prosecution_case_target do
    prosecutionCaseId { SecureRandom.uuid }
    prosecutionCaseReference { 'Random string' }

    factory :realistic_merged_prosecution_case_target do
      prosecutionCaseId { SecureRandom.uuid }
      prosecutionCaseReference { Faker::Alphanumeric.alpha(number: 10).upcase }
    end
  end
end
