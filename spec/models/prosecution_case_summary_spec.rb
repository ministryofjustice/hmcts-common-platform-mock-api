# frozen_string_literal: true

RSpec.describe ProsecutionCaseSummary, type: :model do
  subject { prosecution_case_summary }

  let(:prosecution_case) { FactoryBot.create(:prosecution_case) }
  let(:prosecution_case_summary) { described_class.new(prosecution_case_id: prosecution_case.id) }

  let(:json_schema) { :prosecution_case_summary }

  it_has_behaviour "conforming to valid schema"

  context "with a hearing relationship" do
    before do
      prosecution_case.hearings << FactoryBot.create(:hearing)
      prosecution_case.save!
    end

    it_has_behaviour "conforming to valid schema"
  end
end
