require 'rails_helper'

RSpec.describe AssociatedDefenceOrganisation, type: :model do
  let(:associated_defence_organisation) { FactoryBot.create(:associated_defence_organisation) }
  context 'when sraNumber is present' do
    before do
      associated_defence_organisation.laaContractNumber = nil
      associated_defence_organisation.barCouncilMembershipNumber = nil
    end
    it { should validate_presence_of(:organisation) }
    it { should validate_presence_of(:fundingType) }
    it { should validate_presence_of(:associationStartDate) }
    it { should validate_presence_of(:sraNumber) }
  end

  context 'when laaContactNumber is present' do
    subject { associated_defence_organisation }
    before do
      associated_defence_organisation.laaContractNumber = "dummy num 1"
      associated_defence_organisation.sraNumber = nil
      associated_defence_organisation.barCouncilMembershipNumber = nil
    end
    it { should validate_presence_of(:organisation) }
    it { should validate_presence_of(:fundingType) }
    it { should validate_presence_of(:associationStartDate) }
    it { should validate_presence_of(:laaContractNumber) }
  end

  context 'when barCouncilMembershipNumber is present' do
    subject { associated_defence_organisation }
    before do
      associated_defence_organisation.laaContractNumber = nil
      associated_defence_organisation.sraNumber = nil
      associated_defence_organisation.barCouncilMembershipNumber = "dummy number 2"
    end
    it { should validate_presence_of(:organisation) }
    it { should validate_presence_of(:fundingType) }
    it { should validate_presence_of(:associationStartDate) }
    it { should validate_presence_of(:barCouncilMembershipNumber) }
  end



  it 'matches the given schema' do
    expect(associated_defence_organisation.to_builder.target!).to match_json_schema(:associated_defence_organisation)
  end
end
