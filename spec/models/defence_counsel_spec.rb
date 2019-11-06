# frozen_string_literal: true

RSpec.describe DefenceCounsel, type: :model do
  let(:defence_counsel) { FactoryBot.create(:defence_counsel) }
  let(:json_schema) { :defence_counsel }

  subject { defence_counsel }

  describe 'associations' do
    it { should have_many(:defendants).class_name('Defendant') }
    it { should have_many(:attendance_days).class_name('AttendanceDay') }
  end

  describe 'validations' do
    it { should validate_presence_of(:defendants) }
    it { should validate_presence_of(:attendance_days) }
  end

  it_has_a 'realistic factory'

  it_has_behaviour 'conforming to valid schema'
end
