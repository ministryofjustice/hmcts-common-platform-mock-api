# frozen_string_literal: true

FactoryBot.define do
  factory :court_application do
    # association :application_type, factory: :court_application_type
    applicationReceivedDate { "2019-10-25 16:18:43" }
    applicationReference { "MyString" }
    court_application_party
    court_application_type
    # court_application_outcome { nil }
    linkedCaseId { SecureRandom.uuid }
    linkedSplitProsecutorCaseReference { "MyString" }
    parentApplicationId { SecureRandom.uuid }
    applicationParticulars { "MyString" }
    court_application_payment { nil }
    applicationDecisionSoughtByDate { "2019-10-25 16:18:43" }
    applicationStatus { "LISTED" }
    outOfTimeReasons { "MyString" }
    # breachedOrder { "MyString" }
    breachedOrderDate { "MyString" }
    # after(:build) do |court_application|
    #   court_application.court_application_types << FactoryBot.create(:court_application_type)
    # end
  end
end
