# frozen_string_literal: true

RSpec.describe DefendantSummary, type: :model do
  subject { defendant_summary }

  let(:defendant) { FactoryBot.create(:defendant) }
  let(:defendant_summary) { described_class.new(defendant_id: defendant.id) }

  let(:json_schema) { :defendant_summary }

  it_has_behaviour "conforming to valid schema"

  context "with RepresentationOrder" do
    before do
      FactoryBot.create(:laa_reference, offence: defendant.offences.first)
      FactoryBot.create(:associated_defence_organisation, defendant: defendant)
    end

    it_has_behaviour "conforming to valid schema"
  end

  context "when defendant is a legal entity" do
    let(:defendant) { FactoryBot.create(:defendant_as_legal_entity) }

    it_has_behaviour "conforming to valid schema"
  end

  describe "#date_of_next_hearing " do
    subject { defendant_summary.date_of_next_hearing }

    it { is_expected.to be_blank }

    context "when date_of_next_hearing exists" do
      let(:defendant) do
        create(:defendant, :with_next_hearing,
               next_hearing_date: "2019-01-10")
      end

      it { is_expected.to eq("2019-01-10") }
    end
  end
end
