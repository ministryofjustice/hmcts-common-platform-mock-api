# frozen_string_literal: true

FactoryBot.define do
  factory :lesser_or_alternative_offence do
    offenceDefinitionId { SecureRandom.uuid }
    offenceCode { 'MyString' }
    offenceTitle { 'MyString' }
    offenceTitleWelsh { 'MyString' }
    offenceLegislation { 'MyString' }
    offenceLegislationWelsh { 'MyString' }
  end
end
