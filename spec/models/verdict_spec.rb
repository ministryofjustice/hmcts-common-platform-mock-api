# frozen_string_literal: true

RSpec.describe Verdict, type: :model do
  let(:verdict) { FactoryBot.create(:verdict) }
  let(:json_schema) { :verdict }

  subject { verdict }

  describe 'associations' do
    it { should belong_to(:verdict_type).class_name('VerdictType') }
    it { should belong_to(:jurors).class_name('Jurors').optional }
    it { should belong_to(:lesser_or_alternative_offence).class_name('LesserOrAlternativeOffence').optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:originatingHearingId) }
    it { should validate_presence_of(:offenceId) }
    it { should validate_presence_of(:verdictDate) }
    it { should validate_presence_of(:verdict_type) }
  end

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    let(:verdict) { FactoryBot.create(:verdict_with_relationships) }

    it_has_behaviour 'conforming to valid schema'
  end

  it_has_a 'realistic factory'
end
