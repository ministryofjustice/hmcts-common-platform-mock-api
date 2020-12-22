# frozen_string_literal: true

RSpec.describe DefendantHearingYouthMarker, type: :model do
  subject { defendant_hearing_youth_marker }

  let(:defendant_hearing_youth_marker) { FactoryBot.create(:defendant_hearing_youth_marker) }
  let(:json_schema) { :defendant_hearing_youth_marker }


  describe "associations" do
    it { is_expected.to belong_to(:prosecution_case).class_name("ProsecutionCase") }
    it { is_expected.to belong_to(:defendant).class_name("Defendant") }
    it { is_expected.to belong_to(:marker).class_name("Marker") }
    it { is_expected.to belong_to(:hearing).class_name("Hearing") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:prosecution_case) }
    it { is_expected.to validate_presence_of(:defendant) }
    it { is_expected.to validate_presence_of(:hearing) }
    it { is_expected.to validate_presence_of(:marker) }
  end

  it_has_behaviour "conforming to valid schema"
end
