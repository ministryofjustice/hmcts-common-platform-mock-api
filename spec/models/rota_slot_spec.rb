require "rails_helper"

RSpec.describe RotaSlot, type: :model do
  subject { rota_slot }

  let(:rota_slot) { FactoryBot.create(:rota_slot) }

  let(:json_schema) { :rota_slot }

  describe "validations" do
    it { is_expected.to validate_presence_of(:start_time) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
