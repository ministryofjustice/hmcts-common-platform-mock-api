# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Offence, type: :model do
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

  context 'hmcts schema' do
    let(:offence) { FactoryBot.create(:offence) }

    it 'matches the given schema' do
      expect(offence.to_builder.target!).to match_json_schema(:offence)
    end

    context 'with relationships' do
      before do
        offence.victims << FactoryBot.create(:person)
        offence.judicial_results << FactoryBot.create(:judicial_result)
        offence.laa_references << FactoryBot.create(:laa_reference)
        offence.save!
      end

      it 'matches the given schema' do
        expect(offence.to_builder.target!).to match_json_schema(:offence)
      end
    end
  end
end
