# frozen_string_literal: true

FactoryBot.define do
  factory :court_application_offence do
    offenceCode { 'MyString' }
    offence
    court_application_case
  end
end
