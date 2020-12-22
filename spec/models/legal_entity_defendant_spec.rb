# frozen_string_literal: true

RSpec.describe LegalEntityDefendant, type: :model do
  subject { legal_entity_defendant }

  let(:legal_entity_defendant) { FactoryBot.create(:legal_entity_defendant) }

  let(:json_schema) { :legal_entity_defendant }

  describe "associations" do
    it { is_expected.to belong_to(:organisation).class_name("Organisation") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:organisation) }
  end

  it_has_a "realistic factory"

  context "hmcts schema" do
    it_has_behaviour "conforming to valid schema"
  end
end
