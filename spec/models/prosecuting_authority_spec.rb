# frozen_string_literal: true

RSpec.describe ProsecutingAuthority, type: :model do
  subject { prosecuting_authority }

  let(:prosecuting_authority) { FactoryBot.create(:prosecuting_authority) }

  let(:json_schema) { :prosecuting_authority }


  describe "associations" do
    it { is_expected.to belong_to(:address).class_name("Address").optional }
    it { is_expected.to belong_to(:contact).class_name("ContactNumber").optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:prosecutionAuthorityCode) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"

  context "with relationships" do
    let(:prosecuting_authority) { FactoryBot.create(:prosecuting_authority_with_relationships) }

    it_has_behaviour "conforming to valid schema"
  end
end
