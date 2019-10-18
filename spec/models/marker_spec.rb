# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Marker, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:markerTypeid) }
    it { should validate_presence_of(:markerTypeCode) }
    it { should validate_presence_of(:markerTypeLabel) }
    it { should validate_presence_of(:markerTypeName) }
  end

  let(:marker) { FactoryBot.create(:marker) }

  it 'matches the given schema' do
    expect(marker.to_builder.target!).to match_json_schema(:marker)
  end
end
