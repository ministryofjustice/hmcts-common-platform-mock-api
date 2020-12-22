# frozen_string_literal: true

RSpec.describe HearingCaseNote, type: :model do
  subject { hearing_case_note }

  let(:hearing_case_note) { FactoryBot.create(:hearing_case_note) }
  let(:json_schema) { :hearing_case_note }


  describe "associations" do
    it { is_expected.to belong_to(:hearing).class_name("Hearing") }
    it { is_expected.to belong_to(:court_clerk).class_name("DelegatedPowers") }
    it { is_expected.to have_many(:prosecution_cases).class_name("ProsecutionCase") }
    it { is_expected.to have_many(:prosecution_case_hearing_case_notes).class_name("ProsecutionCaseHearingCaseNote") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:hearing) }
    it { is_expected.to validate_presence_of(:prosecution_cases) }
    it { is_expected.to validate_presence_of(:noteDateTime) }
    it { is_expected.to validate_presence_of(:noteType) }
    it { is_expected.to validate_inclusion_of(:noteType).in_array(%w[HMCTS LEGAL]) }
    it { is_expected.to validate_presence_of(:note) }
    it { is_expected.to validate_presence_of(:court_clerk) }
  end

  it_has_behaviour "conforming to valid schema"
end
