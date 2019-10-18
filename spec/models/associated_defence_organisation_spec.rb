require 'rails_helper'

RSpec.describe AssociatedDefenceOrganisation, type: :model do
  let(:associated_defence_organisation) { FactoryBot.create(:associated_defence_organisation) }
  let(:json_schema) { :associated_defence_organisation } 
  
  subject { associated_defence_organisation }

  it { should validate_presence_of(:organisation) }
  it { should validate_presence_of(:fundingType) }
  it { should validate_presence_of(:associationStartDate) }


  context 'when sraNumber is present' do
    before do
      associated_defence_organisation.laaContractNumber = nil
      associated_defence_organisation.barCouncilMembershipNumber = nil
    end

    it { should validate_presence_of(:sraNumber) }

    it_has_behaviour "conforming to valid schema"
  end

  context 'when laaContactNumber is present' do
    before do
      associated_defence_organisation.laaContractNumber = "dummy num 1"
      associated_defence_organisation.sraNumber = nil
      associated_defence_organisation.barCouncilMembershipNumber = nil
    end

    it { should validate_presence_of(:laaContractNumber) }
    
    it_has_behaviour "conforming to valid schema"
  end

  context 'when barCouncilMembershipNumber is present' do
    before do
      associated_defence_organisation.laaContractNumber = nil
      associated_defence_organisation.sraNumber = nil
      associated_defence_organisation.barCouncilMembershipNumber = "dummy number 2"
    end

    it { should validate_presence_of(:barCouncilMembershipNumber) }

    it_has_behaviour "conforming to valid schema"
  end
end
