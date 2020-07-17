# frozen_string_literal: true

RSpec.describe JudicialResult, type: :model do
  let(:judicial_result) { FactoryBot.create(:judicial_result) }
  let(:json_schema) { :judicial_result }

  subject { judicial_result }

  describe 'associations' do
    it { should belong_to(:court_clerk).class_name('DelegatedPowers').optional }
    it { should belong_to(:delegated_powers).class_name('DelegatedPowers').optional }
    it { should belong_to(:four_eyes_approval).class_name('DelegatedPowers').optional }
    it { should belong_to(:next_hearing).class_name('NextHearing').optional }
    it { should have_many(:user_groups).class_name('UserGroup') }
    it { should have_many(:judicial_result_prompts).class_name('JudicialResultPrompt') }
  end
  describe 'validations' do
    it { should validate_presence_of(:orderedHearingId) }
    it { should validate_presence_of(:label) }
    it { should validate_presence_of(:orderedDate) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:resultText) }
    it { should validate_inclusion_of(:category).in_array(%w[FINAL INTERMEDIARY ANCILLARY]) }
  end

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    let(:judicial_result) { FactoryBot.create(:judicial_result_with_relationships) }

    it_has_behaviour 'conforming to valid schema'
  end
end
