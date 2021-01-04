# frozen_string_literal: true

FactoryBot.define do
  factory :court_indicated_sentence do
    courtIndicatedSentenceTypeId { SecureRandom.uuid }
    courtIndicatedSentenceDescription { "This is a description" }

    factory :realistic_court_indicated_sentence do
      courtIndicatedSentenceDescription { Faker::Lorem.sentence }
    end
  end
end
