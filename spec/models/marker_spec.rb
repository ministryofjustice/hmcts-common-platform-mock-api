# frozen_string_literal: true

RSpec.describe Marker, type: :model do
  subject { marker }

  let(:marker) { FactoryBot.create(:marker) }

  let(:json_schema) { :marker }


  describe "validations" do
    it { is_expected.to validate_presence_of(:markerTypeid) }
    it { is_expected.to validate_presence_of(:markerTypeCode) }
    it { is_expected.to validate_presence_of(:markerTypeLabel) }
  end

  it_has_a "realistic factory"

  it_has_behaviour "conforming to valid schema"
end
