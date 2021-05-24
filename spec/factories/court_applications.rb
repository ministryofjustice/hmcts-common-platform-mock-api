# frozen_string_literal: true

FactoryBot.define do
  factory :court_application do
    applicationReceivedDate { DateTime.now }
    applicationReference { "MyString" }
    parentApplicationId { SecureRandom.uuid }
    applicationParticulars { "MyString" }
    court_application_payment { nil }
    applicationDecisionSoughtByDate { "2019-10-25 16:18:43" }
    applicationStatus { "LISTED" }
    outOfTimeReasons { "MyString" }

    association :court_application_type
    association :court_application_party
  end
end
