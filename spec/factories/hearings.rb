# frozen_string_literal: true

FactoryBot.define do
  factory :hearing do
    jurisdictionType { 'CROWN' }
    reportingRestrictionReason { 'reporting restriction because...' }
    court_centre_id { 'bc4864ca-4b22-3449-9716-a8db1db89905' }
    hearingLanguage { 'WELSH' }
    hasSharedResults { false }
    hearing_type
    cracked_ineffective_trial { nil }
    isEffectiveTrial { false }
    isBoxHearing { false }
    after(:build) do |hearing|
      hearing.hearing_days << FactoryBot.create(:hearing_day_with_relationships)
    end
  end
end
