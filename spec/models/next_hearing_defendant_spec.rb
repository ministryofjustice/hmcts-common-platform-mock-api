require 'rails_helper'

RSpec.describe NextHearingDefendant, type: :model do
  describe 'associations' do
    it { should have_many(:next_hearing_offences).class_name('NextHearingOffence') }
  end

  describe 'validations' do
    it { should validate_presence_of(:next_hearing_offences) }
  end

  let(:next_hearing_defendant) { FactoryBot.create(:next_hearing_defendant) }

  it 'matches the given schema' do
    expect(next_hearing_defendant.to_builder.target!).to match_json_schema(:next_hearing_defendant)
  end
end
