# frozen_string_literal: true

FactoryBot.define do
  factory :hearing_event do
    hearing
    hearingEventDefinitionId { SecureRandom.uuid }
    recordedLabel { 'Random String' }
    eventTime { '2020-04-23 15:05:47' }

    factory :realistic_hearing_event do
      hearing
      hearingEventDefinitionId { SecureRandom.uuid }
      recordedLabel { Faker::Lorem.sentence }
      eventTime { DateTime.now }
      alterable { Faker::Boolean.boolean }
    end
  end
end
