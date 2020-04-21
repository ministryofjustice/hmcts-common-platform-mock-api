# frozen_string_literal: true

RSpec.describe InterpreterIntermediary, type: :model do
  let(:interpreter_intermediary) { FactoryBot.create(:interpreter_intermediary) }

  let(:json_schema) { :interpreter_intermediary }

  subject { interpreter_intermediary }

  describe 'validations' do
    it { should validate_presence_of(:role) }
    it { should validate_inclusion_of(:role).in_array(%w[INTERPRETER INTERMEDIARY]) }
    it { should validate_presence_of(:firstName) }
    it { should validate_presence_of(:lastName) }
    it { should validate_presence_of(:attendant) }
    it { should validate_presence_of(:attendance_days) }
  end

  describe 'associations' do
    it { should belong_to(:attendant).class_name('Attendant') }
    it { should have_many(:attendance_days).class_name('AttendanceDay') }
  end

  it_has_a 'realistic factory'

  it_has_behaviour 'conforming to valid schema'
end
