# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReferralReason, type: :model do
  let(:referral_reason) { FactoryBot.create(:referral_reason) }
  let(:json_schema) { :referral_reason }

  subject { referral_reason }

  describe 'validations' do
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:defendantId) }
  end

  it_has_behaviour 'conforming to valid schema'
end
