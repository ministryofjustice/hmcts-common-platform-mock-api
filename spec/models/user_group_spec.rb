require 'rails_helper'

RSpec.describe UserGroup, type: :model do
  describe 'associations' do
    it { should belong_to(:judicial_result_prompt).class_name('JudicialResultPrompt').optional }
    it { should belong_to(:judicial_result).class_name('JudicialResult').optional }
  end
end
