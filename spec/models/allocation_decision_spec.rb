# frozen_string_literal: true

RSpec.describe AllocationDecision, type: :model do
  subject { allocation_decision }

  let(:allocation_decision) { FactoryBot.create(:allocation_decision) }
  let(:json_schema) { :allocation_decision }


  it { is_expected.to validate_presence_of(:motReasonId) }
  it { is_expected.to validate_presence_of(:motReasonDescription) }
  it { is_expected.to validate_presence_of(:motReasonCode) }
  it { is_expected.to validate_presence_of(:allocationDecisionDate) }
  it { is_expected.to validate_presence_of(:sequenceNumber) }

  describe "associations" do
    it { is_expected.to belong_to(:court_indicated_sentence).class_name("CourtIndicatedSentence").optional }
    it { is_expected.to belong_to(:offence) }
    it { is_expected.to belong_to(:hearing) }
  end

  it_has_a "realistic factory"

  it_has_behaviour "conforming to valid schema"

  context "with relationships" do
    let(:allocation_decision) { FactoryBot.create(:allocation_decision_with_relationships) }

    it_has_behaviour "conforming to valid schema"
  end
end
