# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JudicialResultPromptDurationElement, type: :model do
  let(:judicial_result_prompt_duration_element) { FactoryBot.create(:judicial_result_prompt_duration_element) }

  let(:json_schema) { :judicial_result_prompt_duration_element }

  subject { judicial_result_prompt_duration_element }

  context 'When primaryDurationUnit or primaryDurationValue are present' do
    it { should validate_presence_of(:primaryDurationUnit) }
    it { should validate_presence_of(:primaryDurationValue) }
    it_has_behaviour 'conforming to valid schema'
  end

  context 'When durationStartDate or durationEndDate are present' do
    before do
      judicial_result_prompt_duration_element.primaryDurationUnit = nil
      judicial_result_prompt_duration_element.primaryDurationValue = nil
      judicial_result_prompt_duration_element.durationStartDate = '2019-10-15 13:15:32'
      judicial_result_prompt_duration_element.durationEndDate = '2019-10-15 13:15:32'
    end
    it { should validate_presence_of(:durationStartDate) }
    it { should validate_presence_of(:durationEndDate) }
    it_has_behaviour 'conforming to valid schema'
  end

end
