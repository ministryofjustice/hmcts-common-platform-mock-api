# frozen_string_literal: true

FactoryBot.define do
  factory :referral_reason do
    description { "Random String" }
    defendantId { SecureRandom.uuid }
  end
end
