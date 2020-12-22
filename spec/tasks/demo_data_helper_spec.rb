# frozen_string_literal: true

require "tasks/demo_data_helper"

RSpec.describe DemoDataHelper, type: :helper do
  subject(:instance) { test_class.new }

  let(:test_class) do
    Class.new do
      include DemoDataHelper
    end
  end

  it { is_expected.to respond_to(:prosecution_cases_by_nino, :humanize_defended_item, :humanize_prosecution_case) }

  describe "#prosecution_cases_by_reference" do
    subject(:results) { instance.prosecution_cases_by_reference(urn) }

    let(:urn) { "TESTURN123" }

    before do
      create(
        :realistic_prosecution_case,
        prosecution_case_identifier: create(:realistic_prosecution_case_identifier,
                                            caseURN: urn),
      )
    end

    it "returns array of prosecution cases" do
      is_expected.to all(be_instance_of(ProsecutionCase))
    end

    it "returns matching prosecution cases" do
      expect(results.map { |pc| pc.prosecution_case_identifier.caseURN }).to be_present.and be_all(eql("TESTURN123"))
    end
  end

  describe "#prosecution_cases_by_nino" do
    subject(:results) { instance.prosecution_cases_by_nino(nino) }

    let(:nino) { "JC123456A" }

    before do
      pc = create(:realistic_prosecution_case,
                  prosecution_case_identifier: create(:realistic_prosecution_case_identifier, caseURN: "TESTURN321"))
      pc.defendants.first.defendable.person.update!(nationalInsuranceNumber: nino)
    end

    it "returns array of prosecution cases" do
      is_expected.to all(be_instance_of(ProsecutionCase))
    end

    it "returns matching prosecution cases" do
      expect(results.map { |pc| pc.prosecution_case_identifier.caseURN }).to be_present.and be_all(eql("TESTURN321"))
    end
  end

  describe "#humanize_defended_item" do
    subject { instance.humanize_defended_item(defended_item) }

    context "with defendant person" do
      let(:defended_item) { create(:realistic_defendant).defendable }

      it {
        person = defended_item.person
        is_expected.to eql("Person: #{person.firstName}, #{person.lastName}, #{person.nationalInsuranceNumber}")
      }
    end

    context "with defendant organisation" do
      let(:defended_item) { create(:realistic_defendant, :with_legal_entity_defendant).defendable }

      it { is_expected.to eql("Org: #{defended_item.organisation.name}") }
    end
  end

  describe "#humanize_prosecution_case" do
    subject { instance.humanize_prosecution_case(prosecution_case) }

    context "with Case URN" do
      let(:prosecution_case) do
        create(:realistic_prosecution_case,
               prosecution_case_identifier: create(:realistic_prosecution_case_identifier,
                                                   caseURN: "URN54321", prosecutionAuthorityReference: nil))
      end

      it { is_expected.to eql("URN54321") }
    end

    context "with prosecution authority reference" do
      let(:prosecution_case) do
        create(:realistic_prosecution_case,
               prosecution_case_identifier: create(:realistic_prosecution_case_identifier,
                                                   prosecutionAuthorityReference: "PAR54321",
                                                   caseURN: nil))
      end

      it { is_expected.to eql("PAR54321") }
    end
  end

  describe "#case_details_hash" do
    subject(:results) { instance.case_details_hash(urn) }

    let(:urn) { "TESTURN123" }
    let(:attributes) do
      %i[defendant_id defendant_name offence_id offence_desc mode_of_trial allocation_decisions plea_sentence]
    end

    before do
      create(
        :realistic_prosecution_case,
        prosecution_case_identifier: create(:realistic_prosecution_case_identifier,
                                            caseURN: urn),
      )
    end

    it { is_expected.to be_an Array }

    it { is_expected.to all(be_instance_of(Hash)) }

    it { expect(results.map(&:keys)).to all(contain_exactly(*attributes)) }
  end
end
