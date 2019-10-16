require 'rails_helper'

RSpec.describe JudicialResultPrompt, type: :model do
  describe 'associations' do
    it { should have_many(:user_groups).class_name('UserGroup') }
  end
  describe 'validations' do
    it { should validate_presence_of(:label) }
    it { should validate_inclusion_of(:isAvailableForCourtExtract).in_array([true, false]) }
  end

  let(:judicial_result_prompt) { FactoryBot.create(:judicial_result_prompt) }

  it 'matches the given schema' do
    expect(judicial_result_prompt.to_builder.target!).to match_json_schema(:judicial_result_prompt)
  end
end
