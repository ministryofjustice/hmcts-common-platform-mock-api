# frozen_string_literal: true

RSpec.describe CourtApplicationResponseType, type: :model do
  subject { court_application_response_type }

  let(:court_application_response_type) { FactoryBot.create(:court_application_response_type) }

  let(:json_schema) { :court_application_response_type }


  describe "validations" do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_numericality_of(:sequence).is_greater_than(0) }
  end

  context "hmcts schema" do
    it_has_behaviour "conforming to valid schema"
  end
end
