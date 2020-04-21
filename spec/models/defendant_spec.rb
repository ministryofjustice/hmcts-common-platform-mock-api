# frozen_string_literal: true

RSpec.describe Defendant, type: :model do
  let(:defendant) { FactoryBot.create(:defendant) }
  let(:json_schema) { :defendant }

  subject { defendant }

  describe 'scopes' do
    let!(:defendant_as_person) { FactoryBot.create(:defendant) }
    let!(:defendant_as_legal_entity) { FactoryBot.create(:defendant_as_legal_entity) }

    describe '.people_only' do
      subject { described_class.people_only }

      it { is_expected.to include(defendant_as_person) }
      it { is_expected.not_to include(defendant_as_legal_entity) }
    end

    describe '.legal_entity_only' do
      subject { described_class.legal_entity_only }

      it { is_expected.not_to include(defendant_as_person) }
      it { is_expected.to include(defendant_as_legal_entity) }
    end

    describe '.by_name' do
      let(:organisation) { FactoryBot.create(:organisation, name: 'Altenwerth and Sons') }
      let!(:organisation_defendant) do
        FactoryBot.create(:defendant_as_legal_entity, defendable: FactoryBot.create(:legal_entity_defendant, organisation: organisation))
      end
      let(:person) { FactoryBot.create(:person, firstName: 'Altenwerth') }
      let!(:person_defendant) do
        FactoryBot.create(:defendant, defendable: FactoryBot.create(:person_defendant, person: person))
      end

      let(:name) { 'Altenwerth' }

      subject { described_class.by_name(name) }

      it { is_expected.to include(organisation_defendant) }
      it { is_expected.to include(person_defendant) }
    end

    describe '.by_date_of_next_hearing' do
      let(:next_hearing_date) { '2020-01-10' }

      subject { described_class.by_date_of_next_hearing(next_hearing_date) }

      let!(:defendant_one) { FactoryBot.create(:defendant, :with_next_hearing, next_hearing_date: '2020-01-10') }
      let!(:defendant_two) { FactoryBot.create(:defendant) }

      it { is_expected.to include(defendant_one) }
      it { is_expected.not_to include(defendant_two) }
    end
  end

  describe 'associations' do
    it { should belong_to(:defendable) }
    it { should belong_to(:person_defendant).class_name('PersonDefendant').optional }
    it { should belong_to(:legal_entity_defendant).class_name('LegalEntityDefendant').optional }
    it { should belong_to(:prosecution_case).class_name('ProsecutionCase') }
    it { should have_many(:offences).class_name('Offence').dependent(:destroy) }
    it { should have_many(:laa_references).class_name('LaaReference') }
    it { should have_many(:associated_people).class_name('AssociatedPerson').dependent(:destroy) }
    it { should have_one(:defence_organisation).class_name('DefenceOrganisation').dependent(:destroy) }
    it { should have_many(:defendant_aliases).class_name('DefendantAlias').dependent(:destroy) }
    it { should have_many(:judicial_results).class_name('JudicialResult').dependent(:destroy) }
    it { should have_many(:markers).class_name('Marker').dependent(:destroy) }
    it { should have_many(:split_prosecutor_case_references).class_name('SplitProsecutorCaseReference').dependent(:destroy) }
    it { should have_many(:linked_defendants).class_name('LinkedDefendant').dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:prosecution_case) }
    it { should validate_presence_of(:offences) }
    it { should validate_presence_of(:defendable) }
    it { should be_valid }
  end

  describe '#person?' do
    it { expect(subject.person?).to eq(true) }
  end

  describe '#legal_entity?' do
    it { expect(subject.legal_entity?).to eq(false) }
  end

  context 'when only one SplitProsecutorCaseReference exists' do
    before do
      defendant.split_prosecutor_case_references << build(:split_prosecutor_case_reference)
    end
    it { should_not be_valid }
  end

  context 'when at least two SplitProsecutorCaseReferences exist' do
    before do
      defendant.split_prosecutor_case_references << build_list(:split_prosecutor_case_reference, 2)
    end
    it { should be_valid }
  end

  it_has_behaviour 'conforming to valid schema'

  context 'when defendant is a legal entity' do
    let(:defendant) { FactoryBot.create(:defendant_as_legal_entity) }

    describe '#person?' do
      it { expect(subject.person?).to eq(false) }
    end

    describe '#legal_entity?' do
      it { expect(subject.legal_entity?).to eq(true) }
    end

    it_has_behaviour 'conforming to valid schema'
  end

  context 'with relationships' do
    let(:defendant) { FactoryBot.create(:defendant_with_relationships) }

    it_has_behaviour 'conforming to valid schema'
  end

  it_has_a 'realistic factory'
end
