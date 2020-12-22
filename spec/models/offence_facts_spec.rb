# frozen_string_literal: true

RSpec.describe OffenceFacts, type: :model do
  subject { offence_facts }

  let(:offence_facts) { FactoryBot.create(:offence_facts) }
  let(:json_schema) { :offence_facts }

  describe "validations" do
    it do
      is_expected.to validate_inclusion_of(:vehicleCode)
        .in_array(%w[LARGE_GOODS_VEHICLE PASSENGER_CARRYING_VEHICLE OTHER])
    end
  end

  it_has_behaviour "conforming to valid schema"
  it_has_a "realistic factory"
end
