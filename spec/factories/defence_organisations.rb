# frozen_string_literal: true

FactoryBot.define do
  factory :defence_organisation do
    organisation
    laaContractNumber { 'Random String' }

    factory :realistic_defence_organisation do
      laaContractNumber { Faker::Code.isbn }
    end
  end

  factory :associated_defence_organisation, class: 'DefenceOrganisation' do
    defendant
    organisation
    laaContractNumber { 'Random String' }

    associationStartDate { '2019-10-17 15:20:09' }
    associationEndDate { '2019-10-17 15:20:09' }
    fundingType { 'COURT_APPOINTED' }
    isAssociatedByLAA { false }

    factory :associated_defence_organisation_with_relationships do
      association :organisation, factory: :organisation_with_relationships
    end

    factory :realistic_associated_defence_organisation do
      association :organisation, factory: :realistic_organisation
      associationStartDate { Faker::Date.forward(days: 20) }
      associationEndDate { Faker::Date.forward(days: 60) }
      fundingType { DefenceOrganisation::FUNDING_TYPES.sample }
      isAssociatedByLAA { Faker::Boolean.boolean }

      laaContractNumber { Faker::Code.isbn }
    end
  end
end
