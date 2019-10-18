# frozen_string_literal: true

FactoryBot.define do
  factory :judicial_role_type do
    judicialRoleTypeId { SecureRandom.uuid }
    judiciaryType { 'High Court Judge' }
  end
end
