# frozen_string_literal: true

FactoryBot.define do
  factory :next_hearing do
    hearing_type
    jurisdictionType { 'CROWN' }
    reportingRestrictionReason { 'Random string' }
    adjournmentReason { 'Random string' }
    hearingLanguage { 'WELSH' }
    listedStartDateTime { '2019-10-15 16:57:50' }
    estimatedMinutes { 1 }
    court_centre_id { 'bc4864ca-4b22-3449-9716-a8db1db89905' }

    after(:build) do |next_hearing|
      next_hearing.judicial_roles << build(:judicial_role, next_hearing: nil)
      next_hearing.next_hearing_prosecution_cases << build(:next_hearing_prosecution_case, next_hearing: nil)
      next_hearing.next_hearing_court_applications << build(:next_hearing_court_application, next_hearing: nil)
    end
  end
end
