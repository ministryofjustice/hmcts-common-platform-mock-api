require "rails_helper"

RSpec.describe CourtOrderOffence, type: :model do
  subject { court_order_offence }

  let(:court_order_offence) { FactoryBot.create(:court_order_offence) }

  let(:json_schema) { :court_order_offence }

  describe "associations" do
    it { is_expected.to belong_to(:offence).class_name("Offence") }
    it { is_expected.to belong_to(:prosecution_case_identifier).class_name("ProsecutionCaseIdentifier") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:offence) }
    it { is_expected.to validate_presence_of(:prosecution_case_id) }
    it { is_expected.to validate_presence_of(:prosecution_case_identifier) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
