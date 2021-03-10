require "rails_helper"

RSpec.describe LjaDetail, type: :model do
  subject { lja_detail }

  let(:lja_detail) { FactoryBot.create(:lja_detail) }

  let(:json_schema) { :lja_detail }

  describe "validations" do
    it { is_expected.to validate_presence_of(:lja_code) }
    it { is_expected.to validate_presence_of(:lja_name) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
