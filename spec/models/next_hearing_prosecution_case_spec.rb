# frozen_string_literal: true

RSpec.describe NextHearingProsecutionCase, type: :model do
  let(:next_hearing_prosecution_case) { FactoryBot.create(:next_hearing_prosecution_case) }

  let(:json_schema) { :next_hearing_prosecution_case }

  subject { next_hearing_prosecution_case }

  describe 'associations' do
    it { should have_many(:next_hearing_defendants).class_name('NextHearingDefendant') }
    it { should belong_to(:next_hearing).class_name('NextHearing').optional }
  end

  describe 'validations' do
    it { should validate_presence_of(:next_hearing_defendants) }
  end

  it_has_behaviour 'conforming to valid schema'
  it_has_a 'realistic factory'
end
