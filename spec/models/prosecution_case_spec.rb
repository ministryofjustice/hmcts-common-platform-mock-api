# frozen_string_literal: true

RSpec.describe ProsecutionCase, type: :model do
  let(:prosecution_case) { FactoryBot.create(:prosecution_case) }
  let(:json_schema) { :prosecution_case }

  subject { prosecution_case }

  describe 'associations' do
    it { should belong_to(:hearing).class_name('Hearing').optional }
    it { should belong_to(:prosecution_case_identifier).class_name('ProsecutionCaseIdentifier') }
    it { should belong_to(:police_officer_in_case).class_name('PoliceOfficerInCase').optional }
    it { should belong_to(:merged_prosecution_case).class_name('MergedProsecutionCase').optional }
    it { should have_many(:defendants).class_name('Defendant').dependent(:destroy).inverse_of(:prosecution_case) }
    it { should have_many(:person_only_defendants).class_name('Defendant') }
    it { should have_many(:legal_entity_only_defendants).class_name('Defendant') }
    it { should have_many(:markers).class_name('Marker').dependent(:destroy) }
    it { should have_many(:split_prosecutor_case_references).class_name('SplitProsecutorCaseReference').dependent(:destroy) }
    it { should have_many(:linked_prosecution_cases).class_name('LinkedProsecutionCase').dependent(:destroy) }
    it { should have_many(:prosecution_case_hearing_case_notes).class_name('ProsecutionCaseHearingCaseNote').dependent(:destroy) }
    it { should have_many(:hearing_case_notes).class_name('HearingCaseNote') }
  end

  describe 'validations' do
    it { should validate_presence_of(:prosecution_case_identifier) }
    it { should validate_presence_of(:initiationCode) }
    it { should validate_presence_of(:defendants) }
    it { should validate_presence_of(:caseStatus) }

    it do
      should validate_inclusion_of(:initiationCode)
        .in_array(%w[J Q S C R O Z])
    end

    it do
      should validate_inclusion_of(:caseStatus)
        .in_array(%w[ACTIVE INACTIVE])
    end
  end

  context 'when only one SplitProsecutorCaseReference exists' do
    before do
      prosecution_case.split_prosecutor_case_references << build(:split_prosecutor_case_reference)
    end
    it { should_not be_valid }
  end

  context 'when at least two SplitProsecutorCaseReferences exist' do
    before do
      prosecution_case.split_prosecutor_case_references << build_list(:split_prosecutor_case_reference, 2)
    end
    it { should be_valid }
  end

  it_has_a 'realistic factory'

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    before do
      prosecution_case.defendants << build(:defendant)
      prosecution_case.markers << build(:marker)
      prosecution_case.split_prosecutor_case_references << build_list(:split_prosecutor_case_reference, 2)
      prosecution_case.linked_prosecution_cases << build(:linked_prosecution_case)
      prosecution_case.save!
    end

    it_has_behaviour 'conforming to valid schema'
  end
end
