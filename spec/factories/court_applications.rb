# frozen_string_literal: true

FactoryBot.define do
  factory :court_application do
    applicationReceivedDate { "2019-10-25 16:18:43" }
    applicationReference { "MyString" }
    court_application_party
    court_application_type
    parentApplicationId { SecureRandom.uuid }
    applicationParticulars { "MyString" }
    court_application_payment { nil }
    applicationDecisionSoughtByDate { "2019-10-25 16:18:43" }
    applicationStatus { "LISTED" }
    outOfTimeReasons { "MyString" }
  end
end
