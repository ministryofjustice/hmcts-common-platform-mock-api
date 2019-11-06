# frozen_string_literal: true

FactoryBot.define do
  factory :associated_person do
    person
    role { 'Main man' }
    factory :realistic_associated_person do
      association :person, factory: :realistic_person
      role { Faker::Relationship.familial('extended') }
    end
  end
end
