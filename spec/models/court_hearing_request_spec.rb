require "rails_helper"

RSpec.describe CourtHearingRequest, type: :model do
  subject { court_hearing_request }

  let(:court_hearing_request) { FactoryBot.create(:court_hearing_request) }

  let(:json_schema) { :court_hearing_request }

  describe "associations" do
    it { is_expected.to belong_to(:hearing_type).class_name("HearingType") }
    it { is_expected.to have_many(:rota_slots).class_name("RotaSlot") }
    it { is_expected.to have_many(:judicial_roles).class_name("JudicialRole") }
  end

  describe "validations" do
    it "has a key 'start date' in the column 'week_commencing_date'" do
      expect(court_hearing_request.week_commencing_date).to have_key("startDate")
    end
  end

  it_has_behaviour "conforming to valid schema"

  it_has_a "realistic factory"
end
