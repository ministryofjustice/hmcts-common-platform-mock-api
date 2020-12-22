# frozen_string_literal: true

RSpec.describe AssociatedPerson, type: :model do
  subject { associated_person }

  let(:associated_person) { FactoryBot.create(:associated_person) }

  let(:json_schema) { :associated_person }


  describe "associations" do
    it { is_expected.to belong_to(:person).class_name("Person") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:person) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
