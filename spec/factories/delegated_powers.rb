# frozen_string_literal: true

FactoryBot.define do
  factory :delegated_powers do
    userId { SecureRandom.uuid }
    firstName { "Jane" }
    lastName { "Doe" }
  end
end
