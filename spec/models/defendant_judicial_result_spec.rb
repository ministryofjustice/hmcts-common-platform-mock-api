# frozen_string_literal: true

RSpec.describe DefendantJudicialResult, type: :model do
  let(:defendant_judicial_result) { FactoryBot.create(:defendant_judicial_result) }

  let(:json_schema) { :defendant_judicial_result }

  subject { defendant_judicial_result }

  describe 'validations' do
    it { should validate_presence_of(:masterDefendantId) }
    it { should validate_presence_of(:judicial_result) }
  end

  describe 'associations' do
    it { should belong_to(:judicial_result).class_name('JudicialResult') }
  end

  it_has_a 'realistic factory'

  it_has_behaviour 'conforming to valid schema'
end
