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
  it { should validate_inclusion_of(:isSection22ALowValueShoplifting).in_array([true, false]) }
  it { should validate_inclusion_of(:isDamageValueUnder5000).in_array([true, false]) }
  it { should validate_inclusion_of(:isTreatedAsIndictableOnly).in_array([true, false]) }
  it { should validate_inclusion_of(:sentencingIndicationRequested).in_array([true, false]) }

  describe 'associations' do
    it { should belong_to(:court_indicated_sentence).class_name('CourtIndicatedSentence').optional }
  end

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    before do
      allocation_decision.court_indicated_sentence = FactoryBot.create(:court_indicated_sentence)
      allocation_decision.save!
    end

    it_has_behaviour 'conforming to valid schema'
  end

  it_has_a 'realistic factory'
end
