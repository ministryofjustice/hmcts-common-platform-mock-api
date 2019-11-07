# frozen_string_literal: true

FactoryBot.define do
  factory :court_application_party do
    id { SecureRandom.uuid }
    synonym { 'MyString' }
  end
end
