# frozen_string_literal: true

RSpec.describe PersonDefendant, type: :model do
  let(:person_defendant) { FactoryBot.create(:person_defendant) }
  let(:json_schema) { :person_defendant }

  subject { person_defendant }

  describe 'scopes' do
    describe '.by_name_and_dob' do
      let(:params) { { defendantName: 'John Doe', dateOfBirth: '2000-05-12' } }

      subject { described_class.by_name_and_dob(params) }

      before do
        allow(Person).to receive(:by_name).and_call_original
        allow(Person).to receive(:by_date_of_birth).and_call_original
      end

      it 'calls the by_name and by_date_of_birth scopes on Person' do
        expect(Person).to receive(:by_name).with(params[:defendantName])
        expect(Person).to receive(:by_date_of_birth).with(params[:dateOfBirth])
        subject
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:person).class_name('Person') }
    it { should belong_to(:bail_status).class_name('BailStatus').optional }
    it { should belong_to(:employer_organisation).class_name('Organisation').optional }
  end
  describe 'validations' do
    it { should validate_presence_of(:person) }
    it do
      should validate_inclusion_of(:driverLicenceCode)
        .in_array(%w[FULL PROVISIONAL])
    end
  end

  context 'hmcts schema' do
    it_has_behaviour 'conforming to valid schema'

    context 'required attributes' do
      before { person_defendant.update!(custodyTimeLimit: nil) }

      it_has_behaviour 'conforming to valid schema'
    end

    context 'with relationships' do
      let(:person_defendant) { FactoryBot.create(:person_defendant_with_relationships) }

      it_has_behaviour 'conforming to valid schema'
    end
  end

  it_has_a 'realistic factory'
end
