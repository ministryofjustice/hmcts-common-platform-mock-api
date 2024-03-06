# frozen_string_literal: true

RSpec.describe DefenceOrganisation, type: :model do
  subject { defence_organisation }

  let(:defence_organisation) { FactoryBot.create(:defence_organisation) }
  let(:json_schema) { :defence_organisation }

  describe "associations" do
    it { is_expected.to belong_to(:organisation).class_name("Organisation") }
    it { is_expected.to belong_to(:defendant).class_name("Defendant").optional }
  end

  it { is_expected.to validate_presence_of(:organisation) }

  it_has_behaviour "conforming to valid schema"

  context "when associated with a Defendant" do
    let(:defence_organisation) { FactoryBot.create(:associated_defence_organisation) }
    let(:json_schema) { :associated_defence_organisation }

    it { is_expected.to validate_presence_of(:fundingType) }
    it { is_expected.to validate_presence_of(:associationStartDate) }

    it_has_behaviour "conforming to valid schema"
  end

  describe "#application_reference" do
    subject { defence_organisation.application_reference }

    let(:defence_organisation) { FactoryBot.create(:associated_defence_organisation, defendant:) }
    let(:defendant) { FactoryBot.create(:defendant) }
    let(:laa_reference) { FactoryBot.create(:laa_reference, applicationReference: "10010101010") }

    it { is_expected.to be_nil }

    context "when laa_reference exists" do
      before do
        defendant.offences.first.update!(laa_reference:)
      end

      it { is_expected.to eq("10010101010") }
    end
  end

  it_has_a "realistic factory"
end
