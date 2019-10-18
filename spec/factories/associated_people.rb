# frozen_string_literal: true

FactoryBot.define do
  factory :associated_person do
    person
    role { 'Main man' }
  end
end
