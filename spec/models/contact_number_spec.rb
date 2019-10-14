require 'rails_helper'

RSpec.describe ContactNumber, type: :model do
  describe 'associations' do
    it { should belong_to(:contactable).optional }
  end

  let(:contact_number) { FactoryBot.create(:contact_number) }

  it 'matches the given schema' do
    expect(contact_number.to_builder.target!).to match_json_schema(:contact_number)
  end
end
