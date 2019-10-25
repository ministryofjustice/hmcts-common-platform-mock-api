# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DefenceOrganisation, type: :model do
  let(:defence_organisation) { FactoryBot.create(:defence_organisation) }
  let(:json_schema) { :defence_organisation }

  subject { defence_organisation }

  describe 'associations' do
    it { should belong_to(:organisation).class_name('Organisation') }
  end
  it { should validate_presence_of(:organisation) }

  describe 'when laaContractNumber is present' do
    it { should validate_presence_of(:laaContractNumber) }
    it_has_behaviour 'conforming to valid schema'
  end

  describe 'when sraNumber is present' do
    before do
      defence_organisation.laaContractNumber = nil
      defence_organisation.sraNumber = 'Random Number'
    end
    it { should validate_presence_of(:sraNumber) }
    it_has_behaviour 'conforming to valid schema'
  end

  describe 'when barCouncilMembershipNumber is present' do
    before do
      defence_organisation.laaContractNumber = nil
      defence_organisation.sraNumber = nil
      defence_organisation.barCouncilMembershipNumber = 'Random Number'
    end
    it { should validate_presence_of(:barCouncilMembershipNumber) }
    it_has_behaviour 'conforming to valid schema'
  end
end
