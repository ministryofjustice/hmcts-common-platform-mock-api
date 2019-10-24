# frozen_string_literal: true

FactoryBot.define do
  factory :court_application_outcome do
    originatingHearingId { SecureRandom.uuid }
    applicationId { SecureRandom.uuid }
    applicationOutcomeDate { '2019-10-23 16:27:51' }
    association :application_outcome_type, factory: :court_application_outcome_type
  end
end
