# frozen_string_literal: true

RSpec.describe VerdictType, type: :model do
  subject { verdict_type }

  let(:verdict_type) { FactoryBot.create(:verdict_type) }
  let(:json_schema) { :verdict_type }


  describe "validations" do
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:categoryType) }
  end

  it_has_a "realistic factory"

  it_has_behaviour "conforming to valid schema"
end
