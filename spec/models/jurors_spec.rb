# frozen_string_literal: true

RSpec.describe Jurors, type: :model do
  subject { jurors }

  let(:jurors) { FactoryBot.create(:jurors) }

  let(:json_schema) { :jurors }

  describe "validations" do
    it { is_expected.to validate_presence_of(:numberOfJurors) }
    it { is_expected.to validate_presence_of(:numberOfSplitJurors) }
  end

  it_has_behaviour "conforming to valid schema"
end
