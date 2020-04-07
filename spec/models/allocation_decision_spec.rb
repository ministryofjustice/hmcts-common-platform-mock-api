# frozen_string_literal: true

RSpec.describe AllocationDecision, type: :model do
  let(:allocation_decision) { FactoryBot.create(:allocation_decision) }
  let(:json_schema) { :allocation_decision }

  subject { allocation_decision }

  it { should validate_presence_of(:originatingHearingId) }
  it { should validate_presence_of(:offenceId) }
  it { should validate_presence_of(:motReasonId) }
  it { should validate_presence_of(:motReasonDescription) }
  it { should validate_presence_of(:motReasonCode) }
  it { should validate_presence_of(:allocationDecisionDate) }

  describe 'associations' do
    it { should belong_to(:court_indicated_sentence).class_name('CourtIndicatedSentence').optional }
  end

  it_has_a 'realistic factory'

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    let(:allocation_decision) { FactoryBot.create(:allocation_decision_with_relationships) }

    it_has_behaviour 'conforming to valid schema'
  end
end
