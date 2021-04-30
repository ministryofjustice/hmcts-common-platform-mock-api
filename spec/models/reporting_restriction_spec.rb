require "rails_helper"

RSpec.describe ReportingRestriction, type: :model do
  subject { reporting_restriction }

  let(:reporting_restriction) { FactoryBot.create(:reporting_restriction) }

  let(:json_schema) { :reporting_restriction }

  describe "validations" do
    it { is_expected.to validate_presence_of(:id) }
    it { is_expected.to validate_presence_of(:label) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
