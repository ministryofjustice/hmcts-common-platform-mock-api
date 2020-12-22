# frozen_string_literal: true

RSpec.describe JudicialResultPrompt, type: :model do
  subject { judicial_result_prompt }

  let(:judicial_result_prompt) { FactoryBot.create(:judicial_result_prompt) }

  let(:json_schema) { :judicial_result_prompt }


  describe "associations" do
    it { is_expected.to have_many(:user_groups).class_name("UserGroup") }
    it { is_expected.to belong_to(:judicial_result).class_name("JudicialResult").optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:label) }
  end

  it_has_behaviour "conforming to valid schema"
end
