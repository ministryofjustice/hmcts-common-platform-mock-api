# frozen_string_literal: true

FactoryBot.define do
  factory :defence_organisation do
    organisation
    laaContractNumber { 'Random String' }
    sraNumber { nil }
    barCouncilMembershipNumber { nil }
  end
end
