# frozen_string_literal: true

RSpec.describe CourtCentre, type: :model do
  let(:court_centre) { described_class.new(id: 'bc4864ca-4b22-3449-9716-a8db1db89905') }

  let(:json_schema) { :court_centre }

  subject { court_centre }

  it_has_behaviour 'conforming to valid schema'

  context 'when an address exists' do
    let(:court_centre) { described_class.new(id: 'f8254db1-1683-483e-afb3-b87fde5a0a26') }

    it_has_behaviour 'conforming to valid schema'
  end
end
