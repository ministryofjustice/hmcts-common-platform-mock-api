# frozen_string_literal: true

FactoryBot.define do
  factory :applicant do
    applicant_counsel { nil }

    factory :realistic_applicant do
      association :applicant_counsel, factory: :realistic_applicant_counsel
    end
  end
end
