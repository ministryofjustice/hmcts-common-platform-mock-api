require "rails_helper"

RSpec.describe ApprovalRequest, type: :model do
  subject { approval_request }

  let(:approval_request) { FactoryBot.create(:approval_request) }

  let(:json_schema) { :approval_request }

  describe "validations" do
    it { is_expected.to validate_presence_of(:hearing_id) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:request_approval_time) }
    it { is_expected.to validate_presence_of(:approval_type) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
