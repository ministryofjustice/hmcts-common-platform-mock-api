# frozen_string_literal: true

FactoryBot.define do
  factory :hearing do
    jurisdictionType { 'CROWN' }
    reportingRestrictionReason { 'reporting restriction because...' }
    court_centre_id { '6131bd34-33d9-3d1e-8152-8b5a2084f1bd' }
    hearingLanguage { 'WELSH' }
    hasSharedResults { false }
    hearing_type
    cracked_ineffective_trial { nil }
    isEffectiveTrial { false }
    isBoxHearing { false }
    after(:build) do |hearing|
      hearing.hearing_days << FactoryBot.create(:hearing_day)
    end
  end

  factory :realistic_hearing, class: 'Hearing' do
    hasSharedResults { Faker::Boolean.boolean }
    jurisdictionType { Hearing::JURISDICTION_TYPES.sample }
    reportingRestrictionReason { Faker::Hipster.sentence(word_count: 3, supplemental: true, random_words_to_add: 4) }
    court_centre_id { '6131bd34-33d9-3d1e-8152-8b5a2084f1bd' }
    hearingLanguage { Hearing::LANGUAGES.sample }
    hearing_type
    isEffectiveTrial { Faker::Boolean.boolean }
    isBoxHearing { Faker::Boolean.boolean }
    after(:build) do |hearing|
      hearing.hearing_days << FactoryBot.build(:hearing_day)
    end
  end
end
