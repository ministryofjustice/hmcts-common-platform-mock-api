# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Marker, type: :model do
  let(:marker) { FactoryBot.create(:marker) }

  let(:json_schema) { :marker }

  subject { marker }

  describe 'validations' do
    it { should validate_presence_of(:markerTypeid) }
    it { should validate_presence_of(:markerTypeCode) }
    it { should validate_presence_of(:markerTypeLabel) }
    it { should validate_presence_of(:markerTypeName) }
  end

  it_has_behaviour 'conforming to valid schema'
end
