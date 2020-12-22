# frozen_string_literal: true

RSpec.describe RespondentCounsel, type: :model do
  subject { respondent_counsel }

  let(:respondent_counsel) { FactoryBot.create(:respondent_counsel) }
  let(:json_schema) { :respondent_counsel }


  describe "associations" do
    it { is_expected.to have_many(:court_application_respondents).class_name("CourtApplicationRespondent") }
    it { is_expected.to have_many(:attendance_days).class_name("AttendanceDay") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:court_application_respondents) }
    it { is_expected.to validate_presence_of(:attendance_days) }
  end

  it_has_behaviour "conforming to valid schema"
end
