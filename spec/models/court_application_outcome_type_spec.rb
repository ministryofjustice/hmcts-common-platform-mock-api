# frozen_string_literal: true

RSpec.describe CourtApplicationOutcomeType, type: :model do
  subject { court_application_outcome_type }

  let(:court_application_outcome_type) { FactoryBot.create(:court_application_outcome_type) }

  let(:json_schema) { :court_application_outcome_type }

  describe "validations" do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_numericality_of(:sequence).is_greater_than(0) }
  end

  describe "hmcts schema" do
    it_has_behaviour "conforming to valid schema"
  end
end
