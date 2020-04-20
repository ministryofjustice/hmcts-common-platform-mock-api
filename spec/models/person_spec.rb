# frozen_string_literal: true

RSpec.describe Person, type: :model do
  let(:person) { FactoryBot.create(:person) }
  let(:json_schema) { :person }

  subject { person }

  describe 'scopes' do
    describe '.by_name' do
      let(:name) { 'John JD Doe' }

      subject { described_class.by_name(name) }

      let!(:person_one) { FactoryBot.create(:person, firstName: 'John') }
      let!(:person_two) { FactoryBot.create(:person, firstName: 'John', lastName: 'Doe') }
      let!(:person_three) { FactoryBot.create(:person, firstName: 'John', middleName: 'JD', lastName: 'Doe') }

      it { is_expected.to include(person_one) }
      it { is_expected.to include(person_two) }
      it { is_expected.to include(person_three) }

      context 'omitting middleName' do
        let(:name) { 'John Doe' }

        it { is_expected.to include(person_one) }
        it { is_expected.to include(person_two) }
        it { is_expected.to include(person_three) }
      end

      context 'Single name search' do
        let(:name) { 'Doe' }

        it { is_expected.not_to include(person_one) }
        it { is_expected.to include(person_two) }
        it { is_expected.to include(person_three) }
      end
    end

    describe '.by_date_of_birth' do
      let(:date_of_birth) { '2000-05-12' }

      subject { described_class.by_date_of_birth(date_of_birth) }

      let!(:person_one) { FactoryBot.create(:person, dateOfBirth: '2000-05-12') }
      let!(:person_two) { FactoryBot.create(:person, dateOfBirth: '2012-05-12') }

      it { is_expected.to include(person_one) }
      it { is_expected.not_to include(person_two) }
    end
  end

  describe 'associations' do
    it { should belong_to(:ethnicity).class_name('Ethnicity').optional }
    it { should belong_to(:address).class_name('Address').optional }
    it { should belong_to(:contact_number).class_name('ContactNumber').optional }
  end
  describe 'validations' do
    it { should validate_presence_of(:lastName) }
    it { should validate_presence_of(:gender) }
    it do
      should validate_inclusion_of(:title)
        .in_array(%w[MR MRS MISS MS])
    end

    it do
      should validate_inclusion_of(:gender)
        .in_array(%w[MALE FEMALE NOT_KNOWN NOT_SPECIFIED])
    end

    it do
      should validate_inclusion_of(:documentationLanguageNeeds)
        .in_array(%w[ENGLISH WELSH])
    end
  end

  describe '#name' do
    subject { person.name }

    it { is_expected.to eq('Alfredine Treutel Parker') }

    context 'missing first name' do
      before { person.update!(middleName: nil) }

      it { is_expected.to eq('Alfredine Parker') }
    end

    context 'missing first and middle name' do
      before { person.update!(firstName: nil, middleName: nil) }

      it { is_expected.to eq('Parker') }
    end
  end

  it_has_behaviour 'conforming to valid schema'

  it_has_a 'realistic factory'

  context 'with relationships' do
    let(:person) { FactoryBot.create(:person_with_relationships) }

    it_has_behaviour 'conforming to valid schema'
  end
end
