# frozen_string_literal: true

FactoryBot.define do
  factory :court_application_respondent do
    association :party_details, factory: :court_application_party
  end
end
