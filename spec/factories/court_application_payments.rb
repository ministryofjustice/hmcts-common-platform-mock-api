# frozen_string_literal: true

FactoryBot.define do
  factory :court_application_payment do
    isFeePaid { false }
    isFeeUndertakingAttached { false }
    isFeeExempt { false }
    paymentReference { "MyString" }
  end
end
