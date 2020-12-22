# frozen_string_literal: true

RSpec.describe Address, type: :model do
  subject { address }

  let(:address) { FactoryBot.create(:address) }

  let(:json_schema) { :address }


  describe "validations" do
    it { is_expected.to validate_presence_of(:address1) }
  end

  it_has_a "realistic factory"

  it_has_behaviour "conforming to valid schema"
end
