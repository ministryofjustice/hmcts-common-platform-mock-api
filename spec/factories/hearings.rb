# frozen_string_literal: true

FactoryBot.define do
  factory :hearing do
    jurisdictionType { 'CROWN' }
    reportingRestrictionReason { 'MyString' }
    court_centre
    hearingLanguage { 'WELSH' }
    hasSharedResults { false }
    hearing_type
    cracked_ineffective_trial { nil }
    isEffectiveTrial { false }
    isBoxHearing { false }
    after(:build) do |hearing|
      hearing.hearing_days << FactoryBot.create(:hearing_day)
    end

    trait :with_prosecution_case do
      after(:build) do |hearing|
        hearing.prosecution_cases << FactoryBot.build(:prosecution_case)
      end
    end
  end
end
