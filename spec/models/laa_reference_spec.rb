# frozen_string_literal: true

RSpec.describe LaaReference, type: :model do
  subject { laa_reference }

  let(:laa_reference) { FactoryBot.create(:laa_reference) }

  let(:json_schema) { :laa_reference }


  describe "associations" do
    it { is_expected.to belong_to(:offence).class_name("Offence").optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:applicationReference) }
    it { is_expected.to validate_presence_of(:statusId) }
    it { is_expected.to validate_presence_of(:statusCode) }
    it { is_expected.to validate_presence_of(:statusDescription) }
    it { is_expected.to validate_presence_of(:statusDate) }
  end

  it_has_behaviour "conforming to valid schema"

  describe "#to_builder" do
    context "when all the dates are present" do
      it "returns a JBuilder object" do
        expect(subject.to_builder).to be_an_instance_of(Jbuilder)
      end
    end

    context "when there are missing dates" do
      let(:laa_reference) do
        FactoryBot.create(:laa_reference,
                          effectiveStartDate: nil,
                          effectiveEndDate: nil)
      end

      it "returns a JBuilder object" do
        expect(subject.to_builder).to be_an_instance_of(Jbuilder)
      end

      it_has_behaviour "conforming to valid schema"
    end
  end
end
