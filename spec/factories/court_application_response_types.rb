# frozen_string_literal: true

FactoryBot.define do
  factory :court_application_response_type do
    id { SecureRandom.uuid }
    description { 'MyString' }
    add_attribute(:sequence) { 10 }
  end
end
