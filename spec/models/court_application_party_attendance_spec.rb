# frozen_string_literal: true

RSpec.describe CourtApplicationPartyAttendance, type: :model do
  subject { court_application_party_attendance }

  let(:court_application_party_attendance) { FactoryBot.create(:court_application_party_attendance) }

  let(:json_schema) { :court_application_party_attendance }


  describe "associations" do
    it { is_expected.to belong_to(:court_application_party).class_name("CourtApplicationParty") }
    it { is_expected.to have_many(:attendance_days).class_name("AttendanceDay") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:court_application_party) }
    it { is_expected.to validate_presence_of(:attendance_days) }
  end

  it_has_behaviour "conforming to valid schema"
end
