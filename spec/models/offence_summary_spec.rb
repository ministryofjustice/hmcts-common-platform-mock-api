# frozen_string_literal: true

RSpec.describe OffenceSummary, type: :model do
  subject { offence_summary }

  let(:offence) { FactoryBot.create(:offence) }
  let(:offence_summary) { described_class.new(offence_id: offence.id) }

  let(:json_schema) { :offence_summary }

  describe "hmcts schema" do
    it_has_behaviour "conforming to valid schema"

    context "with relationships" do
      before do
        offence.update!(laa_reference: FactoryBot.create(:laa_reference))
        # binding.pry
      end

      it_has_behaviour "conforming to valid schema"
    end
  end
end
