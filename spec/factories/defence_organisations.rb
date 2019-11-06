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

      factory :realistic_associated_defence_organisation do
        transient do
          has_sra_number { Faker::Boolean.boolean }
          has_laa_contract_number { !has_sra_number || Faker::Boolean.boolean }
        end

        association :organisation, factory: :realistic_organisation
        sraNumber { has_sra_number ? Faker::Code.npi : nil }
        laaContractNumber { has_laa_contract_number ? Faker::Code.isbn : nil }
        barCouncilMembershipNumber { has_laa_contract_number ? nil : Faker::Code.ean }
        associationStartDate { Faker::Date.forward(20) }
        associationEndDate { Faker::Date.forward(60) }
        fundingType { DefenceOrganisation::FUNDING_TYPES.sample }
        isAssociatedByLAA { Faker::Boolean.boolean }
      end
    end
  end
end
