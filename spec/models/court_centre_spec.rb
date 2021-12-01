# frozen_string_literal: true

RSpec.describe CourtCentre, type: :model do
  subject { court_centre }

  let(:court_centre) { described_class.new(id: "6131bd34-33d9-3d1e-8152-8b5a2084f1bd") }

  let(:json_schema) { :court_centre }

  describe "#name" do
    subject { court_centre.name }

    it { is_expected.to eq("Derby Crown Court") }
  end

  it_has_behaviour "conforming to valid schema"
end
