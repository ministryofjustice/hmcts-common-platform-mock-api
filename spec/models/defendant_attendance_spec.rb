# frozen_string_literal: true

RSpec.describe DefendantAttendance, type: :model do
  subject { defendant_attendance }

  let(:defendant_attendance) { FactoryBot.create(:defendant_attendance) }
  let(:json_schema) { :defendant_attendance }

  describe "associations" do
    it { is_expected.to belong_to(:defendant).class_name("Defendant") }
    it { is_expected.to have_many(:attendance_days).class_name("AttendanceDay") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:defendant_id) }
    it { is_expected.to validate_presence_of(:attendance_days) }
  end

  it_has_behaviour "conforming to valid schema"
end
