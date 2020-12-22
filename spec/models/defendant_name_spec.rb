# frozen_string_literal: true

RSpec.describe DefendantName, type: :model do
  subject { defendant_name }

  let(:defendant) { FactoryBot.create(:defendant) }
  let(:defendant_name) { described_class.new(defendant_id: defendant.id) }

  let(:json_schema) { :defendant_name }

  context "when defendant is a person" do
    it_has_behaviour "conforming to valid schema"
  end

  context "when defendant is a legal entity" do
    let(:defendant) { FactoryBot.create(:defendant_as_legal_entity) }

    it_has_behaviour "conforming to valid schema"
  end
end
