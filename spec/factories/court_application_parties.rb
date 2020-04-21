# frozen_string_literal: true

FactoryBot.define do
  factory :court_application_party do
    id { SecureRandom.uuid }
    synonym { 'MyString' }

    factory :court_application_party_with_relationships do
      association :person, factory: :person_with_relationships
      association :organisation, factory: :organisation_with_relationships
      association :representation_organisation, factory: :organisation_with_relationships
      association :prosecuting_authority, factory: :prosecuting_authority_with_relationships
      association :defendant, factory: :defendant_with_relationships
      after(:build) do |court_application_party|
        court_application_party.associated_people << FactoryBot.build(:associated_person_with_relationships)
      end
    end
  end
end
