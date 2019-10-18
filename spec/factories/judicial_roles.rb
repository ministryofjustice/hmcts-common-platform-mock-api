# frozen_string_literal: true

FactoryBot.define do
  factory :judicial_role do
    judicialId { SecureRandom.uuid }
    title { 'MyString' }
    firstName { 'MyString' }
    middleName { 'MyString' }
    lastName { 'MyString' }
    judicial_role_type
    isDeputy { false }
    isBenchChairman { false }
  end
end
