# frozen_string_literal: true

RSpec.describe Offence, type: :model do
  subject { offence }

  let(:offence) { FactoryBot.create(:offence) }
  let(:json_schema) { :offence }

  describe "associations" do
    it { is_expected.to have_many(:notified_pleas).class_name("NotifiedPlea") }
    it { is_expected.to have_many(:indicated_pleas).class_name("IndicatedPlea") }
    it { is_expected.to have_many(:allocation_decisions).class_name("AllocationDecision") }
    it { is_expected.to have_many(:pleas).class_name("Plea") }
    it { is_expected.to belong_to(:offence_facts).class_name("OffenceFacts").optional }
    it { is_expected.to belong_to(:custody_time_limit).class_name("CustodyTimeLimit").optional }
    it { is_expected.to belong_to(:defendant).class_name("Defendant").optional }
    it { is_expected.to belong_to(:committing_court).optional }
    it { is_expected.to have_many(:victims).class_name("Person") }
    it { is_expected.to have_many(:judicial_results).class_name("JudicialResult") }
    it { is_expected.to have_many(:reporting_restrictions) }
    it { is_expected.to have_many(:verdicts).class_name("Verdict") }
    it { is_expected.to have_one(:laa_reference).class_name("LaaReference") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:offenceDefinitionId) }
    it { is_expected.to validate_presence_of(:offenceCode) }
    it { is_expected.to validate_length_of(:offenceCode).is_at_most(8) }
    it { is_expected.to validate_presence_of(:offenceTitle) }
    it { is_expected.to validate_presence_of(:wording) }
    it { is_expected.to validate_presence_of(:startDate) }
  end

  it_has_behaviour "conforming to valid schema"

  context "with relationships" do
    let(:offence) { FactoryBot.create(:offence_with_relationships_and_laa_reference) }

    it_has_behaviour "conforming to valid schema"
  end
end
