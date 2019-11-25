# frozen_string_literal: true

FactoryBot.define do
  factory :defence_organisation do
    organisation
    laaContractNumber { 'Random String' }
    sraNumber { nil }
    barCouncilMembershipNumber { nil }

    factory :associated_defence_organisation do
      defendant
      associationStartDate { '2019-10-17 15:20:09' }
      associationEndDate { '2019-10-17 15:20:09' }
      fundingType { 'COURT_APPOINTED' }
      isAssociatedByLAA { false }
    end
  end
end
