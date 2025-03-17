# frozen_string_literal: true

FactoryBot.define do
  factory :court_application_prosecution_case do
    court_application
    prosecution_case
  end
end
