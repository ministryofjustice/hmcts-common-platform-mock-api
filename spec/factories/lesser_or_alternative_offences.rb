# frozen_string_literal: true

FactoryBot.define do
  factory :lesser_or_alternative_offence do
    offenceDefinitionId { SecureRandom.uuid }
    offenceCode { 'RC86395' }
    offenceTitle { 'MyString' }
    offenceTitleWelsh { 'MyString' }
    offenceLegislation { 'MyString' }
    offenceLegislationWelsh { 'MyString' }

    factory :realistic_lesser_or_alternative_offence do
      offenceDefinitionId { SecureRandom.uuid }
      offenceCode { Faker::Alphanumeric.alphanumeric(number: 6).upcase }
      offenceTitle { Faker::Lorem.word }
      offenceTitleWelsh { Faker::Lorem.word }
      offenceLegislation { Faker::Lorem.sentence }
      offenceLegislationWelsh { Faker::Lorem.sentence }
    end
  end
end
