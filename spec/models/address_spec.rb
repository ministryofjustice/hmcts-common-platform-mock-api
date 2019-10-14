require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'associations' do
    it { should belong_to(:addressable).optional }
  end
  describe 'validations' do
    it { should validate_presence_of(:address1) }
  end

  let(:address) { FactoryBot.create(:address) }

  it 'matches the given schema' do
    expect(address.to_builder.target!).to match_json_schema(:address)
  end
end
