require 'rails_helper'

RSpec.describe PersonDefendant, type: :model do
  describe 'associations' do
    it { should belong_to(:person).class_name('Person') }
    it { should belong_to(:bail_status).class_name('BailStatus').optional }
    it { should belong_to(:employer_organisation).class_name('Organisation').optional }
  end
  describe 'validations' do
    it { should validate_presence_of(:person) }
    it do
      should validate_inclusion_of(:driverLicenceCode).
        in_array(['FULL', 'PROVISIONAL'])
    end
  end

  context 'hmcts schema' do
    let(:person_defendant) { FactoryBot.create(:person_defendant) }

    it 'matches the given schema' do
      expect(person_defendant.to_builder.target!).to match_json_schema(:person_defendant)
    end

    context 'with relationships' do
      before do
        person_defendant.update! bail_status: FactoryBot.create(:bail_status), employer_organisation: FactoryBot.create(:organisation)
      end

      it 'matches the given schema' do
        expect(person_defendant.to_builder.target!).to match_json_schema(:person_defendant)
      end
    end
  end
end
