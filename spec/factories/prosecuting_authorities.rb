# frozen_string_literal: true

FactoryBot.define do
  factory :prosecuting_authority do
    prosecutionAuthorityId { SecureRandom.uuid }
    prosecutionAuthorityCode { 'MyString' }
    name { 'MyString' }
    accountCode { 'MyString' }
    address
  end
end
