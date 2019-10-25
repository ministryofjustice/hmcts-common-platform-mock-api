# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OffenceFacts, type: :model do
  let(:offence_facts) { FactoryBot.create(:offence_facts) }
  let(:json_schema) { :offence_facts }

  subject { offence_facts }

  describe 'validations' do
    it do
      should validate_inclusion_of(:vehicleCode)
        .in_array(%w[LARGE_GOODS_VEHICLE PASSENGER_CARRYING_VEHICLE OTHER])
    end
  end

  it_has_behaviour 'conforming to valid schema'
end
