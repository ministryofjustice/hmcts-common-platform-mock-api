# frozen_string_literal: true

RSpec.describe CourtCentre, type: :model do
  subject { court_centre }

  let(:court_centre) do
    described_class.new(
      id: "6131bd34-33d9-3d1e-8152-8b5a2084f1bd",
      name: "Derby Crown Court",
      welsh_name: "welsh name",
      address1: "address 1",
      address2: "address 2",
      address3: "",
      address4: "",
      address5: "",
      postcode: "SW2 7YH",
    )
  end

  let(:json_schema) { :court_centre }

  describe ".all" do
    it "returns a collection of CourtCentre instances" do
      expect(described_class.all).to all(be_a(described_class))
    end
  end

  it_has_behaviour "conforming to valid schema"
end
