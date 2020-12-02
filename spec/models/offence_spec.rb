# frozen_string_literal: true

RSpec.describe Offence, type: :model do
  let(:offence) { FactoryBot.create(:offence) }
  let(:json_schema) { :offence }

  subject { offence }

  describe 'associations' do
    it { should have_many(:notified_pleas).class_name('NotifiedPlea') }
    it { should have_many(:indicated_pleas).class_name('IndicatedPlea') }
    it { should have_many(:allocation_decisions).class_name('AllocationDecision') }
    it { should have_many(:pleas).class_name('Plea') }
    it { should have_many(:verdicts).class_name('Verdict') }
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
    let(:offence) { FactoryBot.create(:offence_with_relationships_and_laa_reference) }

    it_has_behaviour 'conforming to valid schema'
  end
end
