# frozen_string_literal: true

FactoryBot.define do
  factory :prosecuting_authority do
    prosecutionAuthorityId { SecureRandom.uuid }
    prosecutionAuthorityCode { 'MyString' }
    name { 'MyString' }
    accountCode { 'MyString' }

    factory :prosecuting_authority_with_relationships do
      address
      association :contact, factory: :contact_number
    end

    factory :realistic_prosecuting_authority do
      prosecutionAuthorityId { SecureRandom.uuid }
      prosecutionAuthorityCode { Faker::Code.npi }
      name { Faker::Name.name }
      accountCode { Faker::Code.isbn }
      association :contact, factory: :realistic_contact_number if Faker::Boolean.boolean
      association :address, factory: :realistic_address if Faker::Boolean.boolean
    end
  end
end
