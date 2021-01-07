# frozen_string_literal: true

RSpec.describe JudicialResultPromptDurationElement, type: :model do
  subject { judicial_result_prompt_duration_element }

  let(:judicial_result_prompt_duration_element) { FactoryBot.create(:judicial_result_prompt_duration_element) }

  let(:json_schema) { :judicial_result_prompt_duration_element }

  it { is_expected.to validate_numericality_of(:primaryDurationValue).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(999) }
  it { is_expected.to validate_numericality_of(:secondaryDurationValue).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(999) }
  it { is_expected.to validate_numericality_of(:tertiaryDurationValue).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(999) }

  context "when primaryDurationUnit or primaryDurationValue are present" do
    it { is_expected.to validate_presence_of(:primaryDurationUnit) }
    it { is_expected.to validate_presence_of(:primaryDurationValue) }

    it_has_behaviour "conforming to valid schema"
  end

  context "when durationStartDate or durationEndDate are present" do
    before do
      judicial_result_prompt_duration_element.primaryDurationUnit = nil
      judicial_result_prompt_duration_element.durationStartDate = "2019-10-15 13:15:32"
      judicial_result_prompt_duration_element.durationEndDate = "2019-10-15 13:15:32"
    end

    it { is_expected.to validate_presence_of(:durationStartDate) }
    it { is_expected.to validate_presence_of(:durationEndDate) }

    it_has_behaviour "conforming to valid schema"
  end
end
