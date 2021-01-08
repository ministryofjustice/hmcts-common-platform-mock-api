# frozen_string_literal: true

RSpec.describe MergedProsecutionCase, type: :model do
  subject { merged_prosecution_case }

  let(:merged_prosecution_case) { FactoryBot.create(:merged_prosecution_case) }

  let(:json_schema) { :merged_prosecution_case }

  describe "associations" do
    it { is_expected.to have_many(:merged_prosecution_case_targets).class_name("MergedProsecutionCaseTarget") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:prosecutionCaseReference) }
    it { is_expected.to validate_presence_of(:merged_prosecution_case_targets) }

    describe "merged_prosecution_case_targets" do
      subject { merged_prosecution_case }

      before do
        merged_prosecution_case.merged_prosecution_case_targets = []
        merged_prosecution_case.merged_prosecution_case_targets << FactoryBot.create(:merged_prosecution_case_target)
      end

      context "when only one is present" do
        it { is_expected.not_to be_valid }
      end

      context "when at least two are present" do
        before do
          merged_prosecution_case.merged_prosecution_case_targets << FactoryBot.create(:merged_prosecution_case_target)
        end

        it { is_expected.to be_valid }
      end
    end
  end

  it_has_a "realistic factory"

  it_has_behaviour "conforming to valid schema"
end
