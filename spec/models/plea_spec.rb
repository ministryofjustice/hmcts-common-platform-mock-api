require 'rails_helper'

RSpec.describe Plea, type: :model do
  it { should validate_presence_of(:originatingHearingId) }
  it { should validate_presence_of(:offenceId) }
  it { should validate_presence_of(:pleaDate) }
  it { should validate_presence_of(:pleaValue) }
  it do
    should validate_inclusion_of(:pleaValue).
      in_array(['GUILTY', 'NOT_GUILTY'])
  end

  it { should have_one(:delegated_powers).class_name('DelegatedPowers') }

  let(:plea) { FactoryBot.create(:plea) }

  it 'matches the given schema' do
    expect(plea.to_builder.target!).to match_json_schema(:plea)
  end
end
