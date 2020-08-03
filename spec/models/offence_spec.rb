# frozen_string_literal: true

RSpec.describe Offence, type: :model do
  let(:offence) { FactoryBot.create(:offence) }
  let(:json_schema) { :offence }

  subject { offence }

  describe 'associations' do
    it { should belong_to(:notified_plea).class_name('NotifiedPlea').optional }
    it { should belong_to(:indicated_plea).class_name('IndicatedPlea').optional }
    it { should belong_to(:allocation_decision).class_name('AllocationDecision').optional }
    it { should belong_to(:plea).class_name('Plea').optional }
    it { should belong_to(:verdict).class_name('Verdict').optional }
    it { should belong_to(:offence_facts).class_name('OffenceFacts').optional }
    it { should belong_to(:custody_time_limit).class_name('CustodyTimeLimit').optional }
    it { should belong_to(:defendant).class_name('Defendant').optional }
    it { should have_many(:victims).class_name('Person') }
    it { should have_many(:judicial_results).class_name('JudicialResult') }
    it { should have_one(:laa_reference).class_name('LaaReference') }
  end
  describe 'validations' do
    it { should validate_presence_of(:offenceDefinitionId) }
    it { should validate_presence_of(:offenceCode) }
    it { should validate_length_of(:offenceCode).is_at_most(8) }
    it { should validate_presence_of(:offenceTitle) }
    it { should validate_presence_of(:wording) }
    it { should validate_presence_of(:startDate) }
  end

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    let(:offence) { FactoryBot.create(:offence_with_relationships) }

    it_has_behaviour 'conforming to valid schema'
  end
end
