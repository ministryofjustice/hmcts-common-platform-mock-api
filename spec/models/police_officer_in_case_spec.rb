# frozen_string_literal: true

RSpec.describe PoliceOfficerInCase, type: :model do
  subject { police_officer_in_case }

  let(:police_officer_in_case) { FactoryBot.create(:police_officer_in_case) }
  let(:json_schema) { :police_officer_in_case }


  describe "associations" do
    it { is_expected.to belong_to(:person).class_name("Person").required }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:person) }
    it { is_expected.to validate_presence_of(:policeOfficerRank) }
    it { is_expected.to validate_presence_of(:policeWorkerReferenceNumber) }
    it { is_expected.to validate_presence_of(:policeWorkerLocationCode) }
  end

  it_has_a "realistic factory"

  it_has_behaviour "conforming to valid schema"
end
