require 'rails_helper'

RSpec.describe VerdictType, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:categoryType) }
  end

  let(:verdict_type) { FactoryBot.create(:verdict_type) }

  it 'matches the given schema' do
    expect(verdict_type.to_builder.target!).to match_json_schema(:verdict_type)
  end
end
