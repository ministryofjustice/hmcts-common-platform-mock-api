# frozen_string_literal: true

FactoryBot.define do
  factory :lesser_or_alternative_offence do
    offenceDefinitionId { SecureRandom.uuid }
    offenceCode { 'MyString' }
    offenceTitle { 'MyString' }
    offenceTitleWelsh { 'MyString' }
    offenceLegislation { 'MyString' }
    offenceLegislationWelsh { 'MyString' }

    factory :realistic_lesser_or_alternative_offence do
      offenceDefinitionId { SecureRandom.uuid }
      offenceCode { Faker::Lorem.sentence }
      offenceTitle { Faker::Lorem.word }
      offenceTitleWelsh { Faker::Lorem.word }
      offenceLegislation { Faker::Lorem.sentence }
      offenceLegislationWelsh { Faker::Lorem.sentence }
    end
  end
end
