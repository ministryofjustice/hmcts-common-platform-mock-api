require "rails_helper"

RSpec.describe BoxHearingRequest, type: :model do
  subject { application_verdict }

  let(:application_verdict) { FactoryBot.create(:box_hearing_request) }

  let(:json_schema) { :box_hearing_request }

  describe "validations" do
    it { is_expected.to validate_presence_of(:jurisdiction_type) }
    it { is_expected.to validate_presence_of(:court_centre_id) }
    it { is_expected.to validate_presence_of(:application_due_date) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
