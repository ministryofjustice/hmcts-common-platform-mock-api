require 'rails_helper'

RSpec.describe CourtCentre, type: :model do
  describe 'associations' do
    it { should belong_to(:address).class_name('Address').optional }
  end

  let(:court_centre) { FactoryBot.create(:court_centre) }

  it 'matches the given schema' do
    expect(court_centre.to_builder.target!).to match_json_schema(:court_centre)
  end
end
