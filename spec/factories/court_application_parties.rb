# frozen_string_literal: true

FactoryBot.define do
  factory :court_application_party do
    id { SecureRandom.uuid }
    synonym { %w[appellant complainant appellee suspect].sample }
    summons_required { true }
    notification_required { true }
    appointment_notification_required { true }

    factory :court_application_party_with_relationships do
      association :person, factory: :person_with_relationships
      association :organisation, factory: :organisation_with_relationships
      association :representation_organisation, factory: :organisation_with_relationships
      association :prosecuting_authority, factory: :prosecuting_authority_with_relationships
      association :master_defendant, factory: :master_defendant

      after(:build) do |court_application_party|
        court_application_party.associated_people << FactoryBot.build(:associated_person_with_relationships)
      end
    end
  end
end
