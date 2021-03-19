require "rails_helper"

RSpec.describe MasterDefendant, type: :model do
  subject { master_defendant }

  let(:master_defendant) { FactoryBot.create(:master_defendant) }

  let(:json_schema) { :master_defendant }

  describe "associations" do
    it { is_expected.to belong_to(:person_defendant).class_name("PersonDefendant") }
    it { is_expected.to have_many(:defendant_cases).class_name("DefendantCase") }
    it { is_expected.to have_many(:associated_people).class_name("AssociatedPerson") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:master_defendant_id) }
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
