# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
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
    it { should have_many(:laa_references).class_name('LaaReference') }
  end
  describe 'validations' do
    it { should validate_presence_of(:offenceDefinitionId) }
    it { should validate_presence_of(:offenceCode) }
    it { should validate_presence_of(:offenceTitle) }
    it { should validate_presence_of(:wording) }
    it { should validate_presence_of(:startDate) }
  end

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    before do
      offence.notified_plea = FactoryBot.create(:notified_plea)
      offence.indicated_plea = FactoryBot.create(:indicated_plea)
      offence.allocation_decision = FactoryBot.create(:allocation_decision)
      offence.plea = FactoryBot.create(:plea)
      offence.verdict = FactoryBot.create(:verdict)
      offence.offence_facts = FactoryBot.create(:offence_facts)
      offence.victims << FactoryBot.create(:person)
      offence.judicial_results << FactoryBot.create(:judicial_result)
      offence.laa_references << FactoryBot.create(:laa_reference)
      offence.save!
    end

    it_has_behaviour 'conforming to valid schema'
  end
end
# rubocop:enable Metrics/BlockLength
