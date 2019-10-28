# frozen_string_literal: true

require 'rails_helper'

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
    before do
      verdict.jurors = FactoryBot.create(:jurors)
      verdict.lesser_or_alternative_offence = FactoryBot.create(:lesser_or_alternative_offence)
      verdict.save!
    end

    it_has_behaviour 'conforming to valid schema'
  end
end
