# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Verdict, type: :model do
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

  let(:verdict) { FactoryBot.create(:verdict) }

  it 'matches the given schema' do
    expect(verdict.to_builder.target!).to match_json_schema(:verdict)
  end
end
