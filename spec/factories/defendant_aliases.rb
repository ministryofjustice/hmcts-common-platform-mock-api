# frozen_string_literal: true

FactoryBot.define do
  factory :defendant_alias do
    title { 'MR' }
    firstName { 'James' }
    middleName { 'St' }
    lastName { 'Parker' }
    legalEntityName { 'Bot' }
  end
end
