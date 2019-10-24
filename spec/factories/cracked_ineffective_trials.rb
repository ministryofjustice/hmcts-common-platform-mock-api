# frozen_string_literal: true

FactoryBot.define do
  factory :cracked_ineffective_trial do
    code { 'String' }
    description { 'String' }
    reason_type { 'String' }
  end
end
