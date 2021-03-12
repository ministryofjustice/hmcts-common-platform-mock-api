require "rails_helper"

RSpec.describe PleaModel, type: :model do
  subject { plea_model }

  let(:plea_model) { FactoryBot.create(:plea_model) }

  let(:json_schema) { :plea_model }

  describe "associations" do
    it { is_expected.to belong_to(:indicated_plea).class_name("IndicatedPlea") }
    it { is_expected.to belong_to(:plea).class_name("Plea") }
    it { is_expected.to belong_to(:allocation_decision).class_name("AllocationDecision") }
  end

  describe "validations" do
    context "when the offence id is not present" do
      before { allow(subject).to receive(:offence_id).and_return(false) }

      it { is_expected.to validate_presence_of(:application_id) }
    end

    context "when the application id is not present" do
      before { allow(subject).to receive(:application_id).and_return(false) }

      it { is_expected.to validate_presence_of(:offence_id) }
    end
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
