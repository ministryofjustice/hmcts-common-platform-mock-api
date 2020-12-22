# frozen_string_literal: true

RSpec.describe NextHearing, type: :model do
  subject { next_hearing }

  let(:next_hearing) { FactoryBot.create(:next_hearing) }

  let(:json_schema) { :next_hearing }


  describe "associations" do
    it { is_expected.to have_many(:judicial_roles).class_name("JudicialRole") }
    it { is_expected.to have_many(:next_hearing_prosecution_cases).class_name("NextHearingProsecutionCase") }
    it { is_expected.to have_many(:next_hearing_court_applications).class_name("NextHearingCourtApplication") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:hearing_type) }
    it { is_expected.to validate_presence_of(:court_centre_id) }
    it { is_expected.to validate_presence_of(:estimatedMinutes) }
    it { is_expected.to validate_presence_of(:listedStartDateTime) }

    it do
      is_expected.to validate_inclusion_of(:jurisdictionType)
        .in_array(%w[MAGISTRATES CROWN])
    end

    it do
      is_expected.to validate_inclusion_of(:hearingLanguage)
        .in_array(%w[ENGLISH WELSH])
    end
  end

  it_has_behaviour "conforming to valid schema"

  context "with relationships" do
    before do
      next_hearing.update!(court_centre_id: "6131bd34-33d9-3d1e-8152-8b5a2084f1bd")
    end

    it_has_behaviour "conforming to valid schema"
  end
end
