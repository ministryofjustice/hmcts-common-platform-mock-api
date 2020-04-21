# frozen_string_literal: true

FactoryBot.define do
  factory :lja_details do
    ljaCode { 'Random string' }
    ljaName { 'Random string' }
    welshLjaName { 'Random string' }
    factory :realistic_lja_details do
      ljaCode { 'Random string' }
      ljaName { 'Random string' }
      welshLjaName { 'Random string' }
    end
  end
end
