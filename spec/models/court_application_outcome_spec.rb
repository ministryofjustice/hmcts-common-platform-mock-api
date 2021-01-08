# frozen_string_literal: true

RSpec.describe CourtApplicationOutcome, type: :model do
  subject { court_application_outcome }

  let(:court_application_outcome) { FactoryBot.create(:court_application_outcome) }

  let(:json_schema) { :court_application_outcome }

  describe "associations" do
    it { is_expected.to belong_to(:application_outcome_type).class_name("CourtApplicationOutcomeType") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:originatingHearingId) }
    it { is_expected.to validate_presence_of(:applicationId) }
    it { is_expected.to validate_presence_of(:application_outcome_type) }
    it { is_expected.to validate_presence_of(:applicationOutcomeDate) }
  end

  describe "hmcts schema" do
    it_has_behaviour "conforming to valid schema"
  end
end
