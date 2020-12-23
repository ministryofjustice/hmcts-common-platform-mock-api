# frozen_string_literal: true

RSpec.describe CrackedIneffectiveTrial, type: :model do
  subject { cracked_ineffective_trial }

  let(:cracked_ineffective_trial) { FactoryBot.create(:cracked_ineffective_trial) }
  let(:json_schema) { :cracked_ineffective_trial }

  describe "validations" do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:reason_type) }
  end

  it_has_a "realistic factory"

  it_has_behaviour "conforming to valid schema"
end
