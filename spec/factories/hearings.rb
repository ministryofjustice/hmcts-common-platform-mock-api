# frozen_string_literal: true

FactoryBot.define do
  factory :hearing do
    trait :with_prosecution_case do
      after(:build) do |hearing|
        hearing.prosecution_cases << FactoryBot.create(:prosecution_case)
      end
    end

<<<<<<< HEAD
    hearing_id { "0304d126-d773-41fd-af01-83e017cecd80" }
    sitting_day { "2019-10-23 16:19:15" }
=======
    hearing_id { SecureRandom.uuid }
    sitting_day { Time.zone.today }
>>>>>>> 4133f87 (Add hearing_id and sitting_day options to hearing)
    jurisdictionType { "CROWN" }
    reportingRestrictionReason { "reporting restriction because..." }
    court_centre_id { "6131bd34-33d9-3d1e-8152-8b5a2084f1bd" }
    hearingLanguage { "WELSH" }
    hasSharedResults { false }
    hearing_type
    cracked_ineffective_trial { nil }
    isEffectiveTrial { false }
    isBoxHearing { false }
    after(:build) do |hearing|
      hearing.hearing_days << FactoryBot.create(
        :hearing_day,
        sittingDay: hearing.sitting_day,
        court_centre_id: hearing.court_centre_id,
      )
    end
  end

  factory :realistic_hearing, class: "Hearing" do
    hearing_id { SecureRandom.uuid }
    sitting_day { Time.zone.today }
    hasSharedResults { Faker::Boolean.boolean }
    jurisdictionType { Hearing::JURISDICTION_TYPES.sample }
    reportingRestrictionReason { Faker::Hipster.sentence(word_count: 3, supplemental: true, random_words_to_add: 4) }
    court_centre_id { "6131bd34-33d9-3d1e-8152-8b5a2084f1bd" }
    hearingLanguage { Hearing::LANGUAGES.sample }
    hearing_type
    isEffectiveTrial { Faker::Boolean.boolean }
    isBoxHearing { Faker::Boolean.boolean }

    after(:build) do |hearing|
<<<<<<< HEAD
      hearing.hearing_days << FactoryBot.build(:realistic_hearing_day)
=======
      hearing.hearing_days << FactoryBot.build(
        :hearing_day,
        sittingDay: hearing.sitting_day,
        court_centre_id: hearing.court_centre_id,
      )
>>>>>>> 3eb02f7 (align hearing day creation to new paradigm)
      hearing.court_applications << FactoryBot.build(:court_application)
    end
  end
end
