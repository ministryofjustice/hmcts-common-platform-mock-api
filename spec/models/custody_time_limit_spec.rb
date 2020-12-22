# frozen_string_literal: true

RSpec.describe CustodyTimeLimit, type: :model do
  subject { custody_time_limit }

  let(:custody_time_limit) { FactoryBot.create(:custody_time_limit) }

  let(:json_schema) { :custody_time_limit }


  describe "validations" do
    it { is_expected.to validate_presence_of(:timeLimit) }
    it { is_expected.to validate_presence_of(:daysSpent) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
