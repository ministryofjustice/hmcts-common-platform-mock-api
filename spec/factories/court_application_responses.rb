# frozen_string_literal: true

FactoryBot.define do
  factory :court_application_response do
    originatingHearingId { SecureRandom.uuid }
    applicationId { SecureRandom.uuid }
    applicationResponseDate { '2019-10-25 11:14:54' }
    association :application_response_type, factory: :court_application_response_type
  end
end
