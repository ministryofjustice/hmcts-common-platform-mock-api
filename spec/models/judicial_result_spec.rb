# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'rails_helper'
RSpec.describe JudicialResult, type: :model do
  let(:judicial_result) { FactoryBot.create(:judicial_result) }
  let(:json_schema) { :judicial_result }

  subject { judicial_result }

  describe 'associations' do
    it { should belong_to(:court_clerk).class_name('DelegatedPowers').optional }
    it { should belong_to(:delegated_powers).class_name('DelegatedPowers').optional }
    it { should belong_to(:four_eyes_approval).class_name('DelegatedPowers').optional }
    it { should belong_to(:next_hearing).class_name('NextHearing').optional }
    it { should belong_to(:duration_element).class_name('JudicialResultPromptDurationElement').optional }
    it { should have_many(:user_groups).class_name('UserGroup') }
    it { should have_many(:judicial_result_prompts).class_name('JudicialResultPrompt') }
  end
  describe 'validations' do
    it { should validate_presence_of(:orderedHearingId) }
    it { should validate_presence_of(:label) }
    it { should validate_inclusion_of(:isAdjournmentResult).in_array([true, false]) }
    it { should validate_inclusion_of(:isFinancialResult).in_array([true, false]) }
    it { should validate_inclusion_of(:isConvictedResult).in_array([true, false]) }
    it { should validate_inclusion_of(:isAvailableForCourtExtract).in_array([true, false]) }
    it { should validate_presence_of(:orderedDate) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:resultText) }
    it { should validate_inclusion_of(:terminatesOffenceProceedings).in_array([true, false]) }
    it { should validate_inclusion_of(:isLifeDuration).in_array([true, false]) }
    it { should validate_inclusion_of(:isPublishedAsAPrompt).in_array([true, false]) }
    it { should validate_inclusion_of(:isExcludedFromResults).in_array([true, false]) }
    it { should validate_inclusion_of(:isAlwaysPublished).in_array([true, false]) }
    it { should validate_inclusion_of(:isUrgent).in_array([true, false]) }
    it { should validate_inclusion_of(:isD20).in_array([true, false]) }
    it { should validate_inclusion_of(:category).in_array(%w[FINAL INTERMEDIARY ANCILLARY]) }
  end

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    before do
      judicial_result.court_clerk = FactoryBot.create(:delegated_powers)
      judicial_result.delegated_powers = FactoryBot.create(:delegated_powers)
      judicial_result.four_eyes_approval = FactoryBot.create(:delegated_powers)
      judicial_result.next_hearing = FactoryBot.create(:next_hearing)
      judicial_result.duration_element = FactoryBot.create(:judicial_result_prompt_duration_element)
      judicial_result.save!
    end

    it_has_behaviour 'conforming to valid schema'
  end
end
# rubocop:enable Metrics/BlockLength
