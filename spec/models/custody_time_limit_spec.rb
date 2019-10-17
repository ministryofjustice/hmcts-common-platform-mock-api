require 'rails_helper'

RSpec.describe CustodyTimeLimit, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:timeLimit) }
    it { should validate_presence_of(:daysSpent) }
  end

  let(:custody_time_limit) { FactoryBot.create(:custody_time_limit) }

  it 'matches the given schema' do
    expect(custody_time_limit.to_builder.target!).to match_json_schema(:custody_time_limit)
  end
end
