# frozen_string_literal: true

RSpec.describe ProsecutionCaseIdentifier, type: :model do
  subject { prosecution_case_identifier }

  let(:prosecution_case_identifier) { FactoryBot.create(:prosecution_case_identifier) }
  let(:json_schema) { :prosecution_case_identifier }

  describe "validations" do
    it { is_expected.to validate_presence_of(:prosecutionAuthorityId) }
    it { is_expected.to validate_presence_of(:prosecutionAuthorityCode) }
    it { is_expected.to validate_presence_of(:prosecutionAuthorityReference) }
    it { is_expected.to allow_values("foobarFooba", "buz12345678", "lengthNoBig").for(:caseURN) }
    it { is_expected.not_to allow_values("foo  bar", "buz+-", "lengthTooBig").for(:caseURN) }

    {
      "   " => ["can't be blank"],
      "ABC" => ["caseURN should be 11 characters"],
      "ABCDEFGHIJ!" => ["Only allows alphanumeric letters"],
      "ABC!" => ["caseURN should be 11 characters", "Only allows alphanumeric letters"],
    }.each do |case_urn, messages|
      it "preserves the case URN validation messages for #{case_urn.inspect}" do
        prosecution_case_identifier.caseURN = case_urn

        expect(prosecution_case_identifier).not_to be_valid
        expect(prosecution_case_identifier.errors[:caseURN]).to match_array(messages)
      end
    end
  end

  describe ".by_reference" do
    subject { described_class.by_reference(search_term) }

    let(:search_term) { "INHRBICZKQA" }

    before { prosecution_case_identifier.save! }

    it { is_expected.to eq([prosecution_case_identifier]) }

    context "with non-exact matches" do
      let(:search_term) { "INHRBICZKQ&&!" }

      it { is_expected.to be_empty }
    end

    context "with lowercase searches" do
      let(:search_term) { "inhrbiczkqa" }

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

    it { is_expected.to validate_presence_of(:caseURN) }
    it { is_expected.not_to allow_values(nil, "", "   ").for(:caseURN) }

    it_has_behaviour "conforming to valid schema"
  end
end
