# frozen_string_literal: true

RSpec.describe NextHearingDefendant, type: :model do
  let(:next_hearing_defendant) { FactoryBot.create(:next_hearing_defendant) }

  let(:json_schema) { :next_hearing_defendant }

  subject { next_hearing_defendant }

  describe 'associations' do
    it { should have_many(:next_hearing_offences).class_name('NextHearingOffence') }
  end

  describe 'validations' do
    it { should validate_presence_of(:next_hearing_offences) }
  end

  it_has_a 'realistic factory'
  it_has_behaviour 'conforming to valid schema'
end
