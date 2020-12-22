# frozen_string_literal: true

RSpec.describe CourtApplicationRespondent, type: :model do
  subject { court_application_respondent }

  let(:court_application_respondent) { FactoryBot.create(:court_application_respondent) }

  let(:json_schema) { :court_application_respondent }


  describe "associations" do
    it { is_expected.to belong_to(:party_details).class_name("CourtApplicationParty") }
    it { is_expected.to belong_to(:application_response).class_name("CourtApplicationResponse").optional }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:party_details) }
  end

  context "hmcts schema" do
    it_has_behaviour "conforming to valid schema"

    context "with application_response" do
      before do
        court_application_respondent.update!(application_response: FactoryBot.create(:court_application_response))
      end

      it_has_behaviour "conforming to valid schema"
    end
  end
end
