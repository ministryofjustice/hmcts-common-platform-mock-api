FactoryBot.define do
  factory :associated_defence_organisation do
    organisation
    sraNumber { "MyString" }
    laaContractNumber { "MyString" }
    barCouncilMembershipNumber { "MyString" }
    associationStartDate { "2019-10-17 15:20:09" }
    associationEndDate { "2019-10-17 15:20:09" }
    fundingType { "COURT_APPOINTED" }
    isAssociatedByLAA { false }
  end
end
