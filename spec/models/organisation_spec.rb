require 'rails_helper'

RSpec.describe Organisation, type: :model do
  describe 'associations' do
    it { should belong_to(:address).class_name('Address').optional }
    it { should belong_to(:contact).class_name('ContactNumber').optional }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  let(:organisation) { FactoryBot.create(:organisation) }

  it 'matches the given schema' do
    expect(organisation.to_builder.target!).to match_json_schema(:organisation)
  end
end
