# frozen_string_literal: true

RSpec.describe NextHearingOffence, type: :model do
  let(:next_hearing_offence) { FactoryBot.create(:next_hearing_offence) }

  let(:json_schema) { :next_hearing_offence }

  subject { next_hearing_offence }

  describe 'associations' do
    it { should belong_to(:next_hearing_defendant).class_name('NextHearingDefendant').optional }
  end

  it_has_behaviour 'conforming to valid schema'
end
