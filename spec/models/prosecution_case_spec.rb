# frozen_string_literal: true

RSpec.describe ProsecutionCase, type: :model do
  subject { prosecution_case }

  let(:prosecution_case) { FactoryBot.create(:prosecution_case) }
  let(:json_schema) { :prosecution_case }

  describe "associations" do
    it { is_expected.to have_many(:prosecution_case_hearings).class_name("ProsecutionCaseHearing") }
    it { is_expected.to have_many(:hearings).class_name("Hearing").through(:prosecution_case_hearings) }
    it { is_expected.to belong_to(:prosecution_case_identifier).class_name("ProsecutionCaseIdentifier") }
    it { is_expected.to belong_to(:police_officer_in_case).class_name("PoliceOfficerInCase").optional }
    it { is_expected.to belong_to(:merged_prosecution_case).class_name("MergedProsecutionCase").optional }
    it { is_expected.to have_many(:defendants).class_name("Defendant").dependent(:destroy).inverse_of(:prosecution_case) }
    it { is_expected.to have_many(:person_only_defendants).class_name("Defendant") }
    it { is_expected.to have_many(:legal_entity_only_defendants).class_name("Defendant") }
    it { is_expected.to have_many(:markers).class_name("Marker").dependent(:destroy) }
    it { is_expected.to have_many(:split_prosecutor_case_references).class_name("SplitProsecutorCaseReference").dependent(:destroy) }
    it { is_expected.to have_many(:linked_prosecution_cases).class_name("LinkedProsecutionCase").dependent(:destroy) }
    it { is_expected.to have_many(:prosecution_case_hearing_case_notes).class_name("ProsecutionCaseHearingCaseNote").dependent(:destroy) }
    it { is_expected.to have_many(:hearing_case_notes).class_name("HearingCaseNote") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:prosecution_case_identifier) }
    it { is_expected.to validate_presence_of(:hearings) }
    it { is_expected.to validate_presence_of(:initiationCode) }
    it { is_expected.to validate_presence_of(:defendants) }
    it { is_expected.to validate_presence_of(:caseStatus) }

    it do
      is_expected.to validate_inclusion_of(:initiationCode)
        .in_array(%w[J Q S C R O Z])
    end

    it do
      is_expected.to validate_inclusion_of(:caseStatus)
        .in_array(%w[ACTIVE INACTIVE])
    end
  end

  describe ".search" do
    subject { described_class.search(parameters) }

    let(:prosecution_case_1) { FactoryBot.create(:prosecution_case) }
    let(:prosecution_case_2) do
      FactoryBot.create(:prosecution_case,
                        prosecution_case_identifier: FactoryBot.create(:prosecution_case_identifier, caseURN: "TEST1"))
    end

    let(:parameters) { "TEST" }

    it { is_expected.to include(prosecution_case_2) }
    it { is_expected.not_to include(prosecution_case_1) }
  end

  context "when only one SplitProsecutorCaseReference exists" do
    before do
      prosecution_case.split_prosecutor_case_references << build(:split_prosecutor_case_reference)
    end

    it { is_expected.not_to be_valid }
  end

  context "when at least two SplitProsecutorCaseReferences exist" do
    before do
      prosecution_case.split_prosecutor_case_references << build_list(:split_prosecutor_case_reference, 2)
    end

    it { is_expected.to be_valid }
  end

  it_has_a "realistic factory"

  it_has_behaviour "conforming to valid schema"

  context "with relationships" do
    before do
      prosecution_case.hearings << build(:hearing)
      prosecution_case.police_officer_in_case = build(:police_officer_in_case)
      prosecution_case.merged_prosecution_case = build(:merged_prosecution_case)
      prosecution_case.defendants << build(:defendant)
      prosecution_case.markers << build(:marker)
      prosecution_case.split_prosecutor_case_references << build_list(:split_prosecutor_case_reference, 2)
      prosecution_case.linked_prosecution_cases << build(:linked_prosecution_case)
      prosecution_case.save!
    end

    it_has_behaviour "conforming to valid schema"
  end
end
