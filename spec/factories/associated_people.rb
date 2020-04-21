# frozen_string_literal: true

FactoryBot.define do
  factory :associated_person do
    person
    role { 'Main man' }
    factory :associated_person_with_relationships do
      association :person, factory: :person_with_relationships
    end

    factory :realistic_associated_person do
      association :person, factory: :realistic_person
      role { Faker::Relationship.familial(connection: 'extended') }
    end
  end
end
