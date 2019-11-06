# frozen_string_literal: true

FactoryBot.define do
  factory :cracked_ineffective_trial do
    code { 'String' }
    description { 'String' }
    reason_type { 'String' }
    factory :realistic_cracked_ineffective_trial do
      code { Faker::Code.sin }
      description { Faker::Lorem.sentence }
      reason_type { %w[cracked ineffective vacated].sample }
    end
  end
end
