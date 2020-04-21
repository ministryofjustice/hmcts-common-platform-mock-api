# frozen_string_literal: true

RSpec.describe DefendantSummary, type: :model do
  let(:defendant) { FactoryBot.create(:defendant) }
  let(:defendant_summary) { described_class.new(defendant_id: defendant.id) }

  let(:json_schema) { :defendant_summary }

  subject { defendant_summary }

  it_has_behaviour 'conforming to valid schema'

  context 'with RepresentationOrder' do
    before do
      FactoryBot.create(:laa_reference, offence: defendant.offences.first)
      FactoryBot.create(:associated_defence_organisation, defendant: defendant)
    end

    it_has_behaviour 'conforming to valid schema'
  end

  context 'when defendant is a legal entity' do
    let(:defendant) { FactoryBot.create(:defendant_as_legal_entity) }

    it_has_behaviour 'conforming to valid schema'
  end
end
