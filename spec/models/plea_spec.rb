# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Plea, type: :model do
  it { should validate_presence_of(:originatingHearingId) }
  it { should validate_presence_of(:offenceId) }
  it { should validate_presence_of(:pleaDate) }
  it { should validate_presence_of(:pleaValue) }
  it do
    should validate_inclusion_of(:pleaValue)
      .in_array(%w[GUILTY NOT_GUILTY])
  end

  it { should belong_to(:delegated_powers).class_name('DelegatedPowers').optional }

  let(:plea) { FactoryBot.create(:plea) }

  it 'matches the given schema' do
    expect(plea.to_builder.target!).to match_json_schema(:plea)
  end
end
