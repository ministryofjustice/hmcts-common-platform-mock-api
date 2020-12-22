# frozen_string_literal: true

RSpec.describe ApplicantCounsel, type: :model do
  subject { applicant_counsel }

  let(:applicant_counsel) { FactoryBot.create(:applicant_counsel) }
  let(:json_schema) { :applicant_counsel }

  describe "associations" do
    it { is_expected.to have_many(:applicants).class_name("Applicant") }
    it { is_expected.to have_many(:attendance_days).class_name("AttendanceDay") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:applicants) }
    it { is_expected.to validate_presence_of(:attendance_days) }
  end

  it_has_a "realistic factory"

  it_has_behaviour "conforming to valid schema"
end
