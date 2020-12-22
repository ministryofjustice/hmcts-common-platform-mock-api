# frozen_string_literal: true

RSpec.describe CourtApplicationPartyCounsel, type: :model do
  subject { court_application_party_counsel }

  let(:court_application_party_counsel) { FactoryBot.create(:court_application_party_counsel) }
  let(:json_schema) { :court_application_party_counsel }

  describe "associations" do
    it { is_expected.to have_many(:court_application_parties).class_name("CourtApplicationParty") }
    it { is_expected.to have_many(:attendance_days).class_name("AttendanceDay") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:applicationId) }
    it { is_expected.to validate_presence_of(:attendance_days) }
  end

  it_has_behaviour "conforming to valid schema"

  context "with relationships" do
    let(:court_application_party_counsel) { FactoryBot.create(:court_application_party_counsel_with_relationships) }

    it_has_behaviour "conforming to valid schema"
  end
end
