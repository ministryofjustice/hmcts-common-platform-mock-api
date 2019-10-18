require 'rails_helper'

RSpec.describe MergedProsecutionCaseTarget, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:prosecutionCaseId) }
    it { should validate_presence_of(:prosecutionCaseReference) }
  end

  let(:merged_prosecution_case_target) { FactoryBot.create(:merged_prosecution_case_target) }

  it 'matches the given schema' do
    expect(merged_prosecution_case_target.to_builder.target!).to match_json_schema(:merged_prosecution_case_target)
  end
end
