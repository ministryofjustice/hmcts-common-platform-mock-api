# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JudicialResultPromptDurationElement, type: :model do
  let(:judicial_result_prompt_duration_element) { FactoryBot.create(:judicial_result_prompt_duration_element) }
  context 'When primaryDurationUnit or primaryDurationValue are present' do
    it { should validate_presence_of(:primaryDurationUnit) }
    it { should validate_presence_of(:primaryDurationValue) }
  end

  context 'When durationStartDate or durationEndDate are present' do
    subject { judicial_result_prompt_duration_element }
    before do
      judicial_result_prompt_duration_element.primaryDurationUnit = nil
      judicial_result_prompt_duration_element.primaryDurationValue = nil
    end
    it { should validate_presence_of(:durationStartDate) }
    it { should validate_presence_of(:durationEndDate) }
  end

  it 'matches the given schema' do
    expect(judicial_result_prompt_duration_element.to_builder.target!).to match_json_schema(:judicial_result_prompt_duration_element)
  end
end
