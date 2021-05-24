# frozen_string_literal: true

FactoryBot.define do
  factory :hearing_event do
    hearing_day
    hearingEventDefinitionId { SecureRandom.uuid }
    recordedLabel { "Random String" }
    note { "Free text" }
    eventTime { "15:05:47" }

    factory :realistic_hearing_event do
      hearingEventDefinitionId { SecureRandom.uuid }
      recordedLabel { Faker::Lorem.sentence }
      note { Faker::Lorem.sentence }
      eventTime { Time.zone.now }
      alterable { Faker::Boolean.boolean }
    end
  end
end
