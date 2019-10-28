# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Plea, type: :model do
  let(:plea) { FactoryBot.create(:plea) }
  let(:json_schema) { :plea }

  subject { plea }

  it { should validate_presence_of(:originatingHearingId) }
  it { should validate_presence_of(:offenceId) }
  it { should validate_presence_of(:pleaDate) }
  it { should validate_presence_of(:pleaValue) }
  it do
    should validate_inclusion_of(:pleaValue)
      .in_array(%w[GUILTY NOT_GUILTY])
  end

  it { should belong_to(:delegated_powers).class_name('DelegatedPowers').optional }

  it_has_behaviour 'conforming to valid schema'

  context 'with relationships' do
    before do
      plea.delegated_powers = FactoryBot.create(:delegated_powers)
      plea.save!
    end

    it_has_behaviour 'conforming to valid schema'
  end
end
