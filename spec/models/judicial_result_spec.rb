# frozen_string_literal: true

RSpec.describe JudicialResult, type: :model do
  subject { judicial_result }

  let(:judicial_result) { FactoryBot.create(:judicial_result) }
  let(:json_schema) { :judicial_result }

  describe "associations" do
    it { is_expected.to belong_to(:court_clerk).class_name("DelegatedPowers").optional }
    it { is_expected.to belong_to(:delegated_powers).class_name("DelegatedPowers").optional }
    it { is_expected.to belong_to(:four_eyes_approval).class_name("DelegatedPowers").optional }
    it { is_expected.to belong_to(:next_hearing).class_name("NextHearing").optional }
    it { is_expected.to have_many(:user_groups).class_name("UserGroup") }
    it { is_expected.to have_many(:judicial_result_prompts).class_name("JudicialResultPrompt") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:label) }
    it { is_expected.to validate_presence_of(:orderedDate) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:resultText) }
    it { is_expected.to validate_inclusion_of(:category).in_array(described_class::CATEGORIES) }
    it { is_expected.to validate_inclusion_of(:postHearingCustodyStatus).in_array(described_class::POST_HEARING_CUSTODY_STATUSES) }
  end

  it_has_behaviour "conforming to valid schema"

  context "with relationships" do
    let(:judicial_result) { FactoryBot.create(:judicial_result_with_relationships) }

    it_has_behaviour "conforming to valid schema"
  end
end
