# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OffenceFacts, type: :model do
  describe 'validations' do
    it do
      should validate_inclusion_of(:vehicleCode)
        .in_array(%w[LARGE_GOODS_VEHICLE PASSENGER_CARRYING_VEHICLE OTHER])
    end
  end

  let(:offence_facts) { FactoryBot.create(:offence_facts) }

  it 'matches the given schema' do
    expect(offence_facts.to_builder.target!).to match_json_schema(:offence_facts)
  end
end
