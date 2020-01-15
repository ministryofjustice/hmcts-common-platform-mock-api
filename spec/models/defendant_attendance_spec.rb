# frozen_string_literal: true

RSpec.describe DefendantAttendance, type: :model do
  let(:defendant_attendance) { FactoryBot.create(:defendant_attendance) }
  let(:json_schema) { :defendant_attendance }

  subject { defendant_attendance }

  describe 'associations' do
    it { should belong_to(:defendant).class_name('Defendant') }
    it { should have_many(:attendance_days).class_name('AttendanceDay') }
  end
  describe 'validations' do
    it { should validate_presence_of(:defendant_id) }
    it { should validate_presence_of(:attendance_days) }
  end

  it_has_behaviour 'conforming to valid schema'
end
