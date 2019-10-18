# frozen_string_literal: true

FactoryBot.define do
  factory :organisation do
    name { 'Random string' }
    incorporationNumber { 'Random string' }
    registeredCharityNumber { 'Random string' }
  end
end
