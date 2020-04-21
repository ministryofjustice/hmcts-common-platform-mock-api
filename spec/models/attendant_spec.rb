# frozen_string_literal: true

RSpec.describe Attendant, type: :model do
  let(:attendant) { FactoryBot.create(:attendant) }

  let(:json_schema) { :attendant }

  subject { attendant }

  describe 'validations' do
    it { should validate_presence_of(:attendantType) }
    it { should validate_inclusion_of(:attendantType).in_array(%w[DEFENDANTS WITNESS]) }
  end

  describe 'associations' do
    it { should belong_to(:defendant).class_name('Defendant').optional }
  end

  it_has_a 'realistic factory'

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    before do
      attendant.defendant = FactoryBot.create(:defendant)
      attendant.save!
    end

    it_has_behaviour 'conforming to valid schema'
  end
end
