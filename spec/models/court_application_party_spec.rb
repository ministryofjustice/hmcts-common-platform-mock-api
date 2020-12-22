# frozen_string_literal: true

RSpec.describe CourtApplicationParty, type: :model do
  subject { court_application_party }

  let(:court_application_party) { FactoryBot.create(:court_application_party) }

  let(:json_schema) { :court_application_party }


  describe "associations" do
    it { is_expected.to have_many(:associated_people).class_name("AssociatedPerson") }
    it { is_expected.to belong_to(:person).class_name("Person").optional }
    it { is_expected.to belong_to(:organisation).class_name("Organisation").optional }
    it { is_expected.to belong_to(:prosecuting_authority).class_name("ProsecutingAuthority").optional }
    it { is_expected.to belong_to(:defendant).class_name("Defendant").optional }
    it { is_expected.to belong_to(:representation_organisation).class_name("Organisation").optional }
  end

  it_has_behaviour "conforming to valid schema"

  context "with relationships" do
    let(:court_application_party) { FactoryBot.create(:court_application_party_with_relationships) }

    it_has_behaviour "conforming to valid schema"
  end
end
