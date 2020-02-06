# frozen_string_literal: true

RSpec.describe OffenceSummary, type: :model do
  let(:offence) { FactoryBot.create(:offence) }
  let(:offence_summary) { described_class.new(offence_id: offence.id) }

  let(:json_schema) { :offence_summary }

  subject { offence_summary }

  context 'hmcts schema' do
    it_has_behaviour 'conforming to valid schema'

    context 'with relationships' do
      before do
        offence.laa_references << FactoryBot.create(:laa_reference)
        offence.save!
      end

      it_has_behaviour 'conforming to valid schema'
    end
  end
end
