# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Defendant, type: :model do
  let(:defendant) { FactoryBot.create(:defendant) }
  let(:json_schema) { :defendant }

  subject { defendant }

  describe 'associations' do
    it { should belong_to(:defendable) }
    it { should belong_to(:prosecution_case).class_name('ProsecutionCase').optional }
    it { should have_many(:offences).class_name('Offence') }
    it { should have_many(:associated_people).class_name('AssociatedPerson') }
    it { should have_many(:associated_defence_organisations).class_name('AssociatedDefenceOrganisation') }
    it { should have_many(:defendant_aliases).class_name('DefendantAlias') }
    it { should have_many(:judicial_results).class_name('JudicialResult') }
    it { should have_many(:markers).class_name('Marker') }
    it { should have_many(:split_prosecutor_case_references).class_name('SplitProsecutorCaseReference') }
    it { should have_many(:linked_defendants).class_name('LinkedDefendant') }
  end

  describe 'validations' do
    it { should validate_presence_of(:prosecutionCaseId) }
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
      defendant.split_prosecutor_case_references << FactoryBot.build(:split_prosecutor_case_reference)
    end
    it { should_not be_valid }
  end

  context 'when at least two SplitProsecutorCaseReferences exist' do
    before do
      defendant.split_prosecutor_case_references << FactoryBot.build_list(:split_prosecutor_case_reference, 2)
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
    before do
      defendant.offences << FactoryBot.create(:offence)
      defendant.associated_people << FactoryBot.create(:associated_person)
      defendant.associated_defence_organisations << FactoryBot.create(:associated_defence_organisation)
      defendant.defendant_aliases << FactoryBot.create(:defendant_alias)
      defendant.judicial_results << FactoryBot.create(:judicial_result)
      defendant.markers << FactoryBot.create(:marker)
      defendant.split_prosecutor_case_references << FactoryBot.create_list(:split_prosecutor_case_reference, 2)
      defendant.linked_defendants << FactoryBot.create(:linked_defendant)
      defendant.save!
    end

    it_has_behaviour 'conforming to valid schema'
  end
end
# rubocop:enable Metrics/BlockLength
