# frozen_string_literal: true

FactoryBot.define do
  factory :judicial_role_type do
    judicialRoleTypeId { SecureRandom.uuid }
    judiciaryType { 'High Court Judge' }

    factory :realistic_judicial_role_type do
      judicialRoleTypeId { SecureRandom.uuid }
      judiciaryType { Faker::Lorem.sentence }
    end
  end
end
