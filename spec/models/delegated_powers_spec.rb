require 'rails_helper'

RSpec.describe DelegatedPowers, type: :model do
  it { should validate_presence_of(:userId) }
  it { should validate_presence_of(:firstName) }
  it { should validate_presence_of(:lastName) }

  let(:delegated_powers) { FactoryBot.create(:delegated_powers) }

  it 'matches the given schema' do
    expect(delegated_powers.to_builder.target!).to match_json_schema(:delegated_powers)
  end
end
