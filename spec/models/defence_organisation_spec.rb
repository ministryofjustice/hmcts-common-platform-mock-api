# frozen_string_literal: true

RSpec.describe DefenceOrganisation, type: :model do
  let(:defence_organisation) { FactoryBot.create(:defence_organisation) }
  let(:json_schema) { :defence_organisation }

  subject { defence_organisation }

  describe 'associations' do
    it { should belong_to(:organisation).class_name('Organisation') }
    it { should belong_to(:defendant).class_name('Defendant').optional }
  end
  it { should validate_presence_of(:organisation) }
  it { should validate_presence_of(:laaContractNumber) }

  it_has_behaviour 'conforming to valid schema'

  context 'when associated with a Defendant' do
    let(:defence_organisation) { FactoryBot.create(:associated_defence_organisation) }
    let(:json_schema) { :associated_defence_organisation }

    it { should validate_presence_of(:fundingType) }
    it { should validate_presence_of(:associationStartDate) }

    it_has_behaviour 'conforming to valid schema'
  end

  describe '#application_reference' do
    let(:defence_organisation) { FactoryBot.create(:associated_defence_organisation, defendant: defendant) }
    let(:defendant) { FactoryBot.create(:defendant) }
    let(:laa_reference) { FactoryBot.create(:laa_reference, applicationReference: '10010101010') }

    subject { defence_organisation.application_reference }

    it { is_expected.to be_nil }

    context 'when laa_reference exists' do
      before do
        defendant.offences.first.update!(laa_reference: laa_reference)
      end

      it { is_expected.to eq('10010101010') }
    end
  end

  it_has_a 'realistic factory'
end
