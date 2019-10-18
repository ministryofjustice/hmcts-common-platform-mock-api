# frozen_string_literal: true

FactoryBot.define do
  factory :merged_prosecution_case_target do
    prosecutionCaseId { SecureRandom.uuid }
    prosecutionCaseReference { 'Random string' }
  end
end
