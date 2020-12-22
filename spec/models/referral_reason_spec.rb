# frozen_string_literal: true

RSpec.describe ReferralReason, type: :model do
  subject { referral_reason }

  let(:referral_reason) { FactoryBot.create(:referral_reason) }
  let(:json_schema) { :referral_reason }


  describe "validations" do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:defendantId) }
  end

  it_has_behaviour "conforming to valid schema"
end
