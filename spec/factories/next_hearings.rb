FactoryBot.define do
  factory :next_hearing do
    hearing_type
    jurisdictionType { 'CROWN' }
    reportingRestrictionReason { 'Random string' }
    adjournmentReason { 'Random string' }
    hearingLanguage { 'WELSH' }
    listedStartDateTime { "2019-10-15 16:57:50" }
    estimatedMinutes { 1 }
    court_centre
  end
end
