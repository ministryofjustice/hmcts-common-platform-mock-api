# frozen_string_literal: true

RSpec.describe ProsecutionCaseIdentifier, type: :model do
  subject { prosecution_case_identifier }

  let(:prosecution_case_identifier) { FactoryBot.create(:prosecution_case_identifier) }
  let(:json_schema) { :prosecution_case_identifier }

  describe "validations" do
    it { is_expected.to validate_presence_of(:prosecutionAuthorityId) }
    it { is_expected.to validate_presence_of(:prosecutionAuthorityCode) }
  end

  describe ".by_reference" do
    subject { described_class.by_reference(search_term) }

    let(:search_term) { "INHRBICZKQ" }

    before { prosecution_case_identifier.save! }

    it { is_expected.to eq([prosecution_case_identifier]) }

    context "non-exact matches" do
      let(:search_term) { "INHRBICZKQ&&!" }

      it { is_expected.to be_empty }
    end

    context "lowercase searches" do
      let(:search_term) { "inhrbiczkq" }

      it { is_expected.to eq([prosecution_case_identifier]) }
    end
  end

  it_has_a "realistic factory"

  context "when caseURN is present" do
    it { is_expected.to validate_presence_of(:caseURN) }

    it_has_behaviour "conforming to valid schema"
  end

  context "when prosecutionAuthorityReference is present" do
    let(:prosecution_case_identifier) { FactoryBot.create(:prosecution_case_identifier_with_reference) }

    it { is_expected.to validate_presence_of(:prosecutionAuthorityReference) }

    it_has_behaviour "conforming to valid schema"
  end
end
