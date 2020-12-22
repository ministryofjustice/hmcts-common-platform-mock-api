# frozen_string_literal: true

RSpec.describe Organisation, type: :model do
  subject { organisation }

  let(:organisation) { FactoryBot.create(:organisation) }
  let(:json_schema) { :organisation }

  describe "scopes" do
    describe ".by_name" do
      subject { described_class.by_name(name) }

      let(:name) { "Altenwerth and Sons" }
      let!(:organisation_one) { FactoryBot.create(:organisation, name: "Altenwerth and Sons") }
      let!(:organisation_two) { FactoryBot.create(:organisation) }

      it { is_expected.to include(organisation_one) }
      it { is_expected.not_to include(organisation_two) }
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:address).class_name("Address").optional }
    it { is_expected.to belong_to(:contact).class_name("ContactNumber").optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  it_has_a "realistic factory"

  it_has_behaviour "conforming to valid schema"

  context "with relationships" do
    let(:organisation) { FactoryBot.create(:organisation_with_relationships) }

    it_has_behaviour "conforming to valid schema"
  end
end
