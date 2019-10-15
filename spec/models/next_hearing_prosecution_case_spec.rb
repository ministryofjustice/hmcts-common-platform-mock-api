require 'rails_helper'

RSpec.describe NextHearingProsecutionCase, type: :model do
  describe 'associations' do
    it { should have_many(:next_hearing_defendants).class_name('NextHearingDefendant') }
  end

  describe 'validations' do
    it { should validate_presence_of(:next_hearing_defendants) }
  end

  let(:next_hearing_prosecution_case) { FactoryBot.create(:next_hearing_prosecution_case) }

  it 'matches the given schema' do
    expect(next_hearing_prosecution_case.to_builder.target!).to match_json_schema(:next_hearing_prosecution_case)
  end
end
