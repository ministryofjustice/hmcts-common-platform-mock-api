require "rails_helper"

RSpec.describe DefendantCase, type: :model do
  subject { defendant_case }

  let(:defendant_case) { FactoryBot.create(:defendant_case) }
  let(:json_schema) { :defendant_case }

  describe "validations" do
    it { is_expected.to validate_presence_of(:defendant_id) }
    it { is_expected.to validate_presence_of(:case_id) }
  end

  it_has_behaviour "conforming to valid schema"
end
