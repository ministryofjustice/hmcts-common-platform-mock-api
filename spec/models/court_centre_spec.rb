# frozen_string_literal: true

RSpec.describe CourtCentre, type: :model do
  subject { court_centre }

  let(:court_centre) { described_class.find_by(id: "6131bd34-33d9-3d1e-8152-8b5a2084f1bd") }

  let(:json_schema) { :court_centre }

  describe ".all" do
    it "returns a collection of CourtCentre instances" do
      expect(described_class.all).to all(be_a(described_class))
    end
  end

  describe ".find_by" do
    it "returns the expected CourtCentre" do
      expect(described_class.find_by(id: "6131bd34-33d9-3d1e-8152-8b5a2084f1bd").name).to eq("Derby Crown Court")
    end
  end

  it_has_behaviour "conforming to valid schema"
end
