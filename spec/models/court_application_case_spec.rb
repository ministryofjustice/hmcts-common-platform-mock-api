require "rails_helper"

RSpec.describe CourtApplicationCase, type: :model do
  subject { court_application_case }

  let(:court_application_case) { FactoryBot.create(:court_application_case) }

  let(:json_schema) { :court_application_case }

  describe "associations" do
    it { is_expected.to belong_to(:prosecution_case_identifier).class_name("ProsecutionCaseIdentifier") }
    it { is_expected.to have_many(:offences).class_name("Offence") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:prosecution_case_id) }
    it { is_expected.to validate_presence_of(:prosecution_case_identifier) }
    it { is_expected.to validate_presence_of(:case_status) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
