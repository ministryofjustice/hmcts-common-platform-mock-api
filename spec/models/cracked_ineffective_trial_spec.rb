# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CrackedIneffectiveTrial, type: :model do
  let(:cracked_ineffective_trial) { FactoryBot.create(:cracked_ineffective_trial) }
  let(:json_schema) { :cracked_ineffective_trial }

  subject { cracked_ineffective_trial }

  describe 'validations' do
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:reason_type) }
  end

  it_has_behaviour 'conforming to valid schema'
end
