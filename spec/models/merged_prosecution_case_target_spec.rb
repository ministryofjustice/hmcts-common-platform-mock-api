# frozen_string_literal: true

RSpec.describe MergedProsecutionCaseTarget, type: :model do
  subject { merged_prosecution_case_target }

  let(:merged_prosecution_case_target) { FactoryBot.create(:merged_prosecution_case_target) }

  let(:json_schema) { :merged_prosecution_case_target }


  describe "validations" do
    it { is_expected.to validate_presence_of(:prosecutionCaseId) }
    it { is_expected.to validate_presence_of(:prosecutionCaseReference) }
  end

  it_has_a "realistic factory"

  it_has_behaviour "conforming to valid schema"
end
