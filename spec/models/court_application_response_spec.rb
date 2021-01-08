# frozen_string_literal: true

RSpec.describe CourtApplicationResponse, type: :model do
  subject { court_application_response }

  let(:court_application_response) { FactoryBot.create(:court_application_response) }

  let(:json_schema) { :court_application_response }

  describe "associations" do
    it { is_expected.to belong_to(:application_response_type).class_name("CourtApplicationResponseType") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:originatingHearingId) }
    it { is_expected.to validate_presence_of(:applicationId) }
    it { is_expected.to validate_presence_of(:applicationResponseDate) }
    it { is_expected.to validate_presence_of(:application_response_type) }
  end

  describe "hmcts schema" do
    it_has_behaviour "conforming to valid schema"
  end
end
