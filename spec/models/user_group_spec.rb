# frozen_string_literal: true

RSpec.describe UserGroup, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:judicial_result_prompt).class_name("JudicialResultPrompt").optional }
    it { is_expected.to belong_to(:judicial_result).class_name("JudicialResult").optional }
  end

  it_has_a "realistic factory"
end
