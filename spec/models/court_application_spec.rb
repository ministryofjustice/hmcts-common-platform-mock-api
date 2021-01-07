# frozen_string_literal: true

RSpec.describe CourtApplication, type: :model do
  subject { court_application }

  let(:court_application) { FactoryBot.create(:court_application) }
  let(:json_schema) { :court_application }

  describe "associations" do
    it { is_expected.to belong_to(:application_type).class_name("CourtApplicationType") }
    it { is_expected.to belong_to(:court_application_party).class_name("CourtApplicationParty") }
    it { is_expected.to belong_to(:court_application_outcome).class_name("CourtApplicationOutcome").optional }
    it { is_expected.to belong_to(:court_application_payment).class_name("CourtApplicationPayment").optional }
    it { is_expected.to have_many(:court_application_respondents).class_name("CourtApplicationRespondent") }
    it { is_expected.to have_many(:judicial_results).class_name("JudicialResult") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:application_type) }
    it { is_expected.to validate_presence_of(:applicationReceivedDate) }
    it { is_expected.to validate_presence_of(:court_application_party) }
    it { is_expected.to validate_presence_of(:applicationStatus) }
    it { is_expected.to validate_inclusion_of(:applicationStatus).in_array(%w[DRAFT LISTED FINALISED]) }
  end

  it_has_behaviour "conforming to valid schema"

  describe "hmcts schema" do
    before do
      court_application.court_application_respondents << FactoryBot.create(:court_application_respondent)
      court_application.court_application_outcome = FactoryBot.create(:court_application_outcome)
      court_application.court_application_payment = FactoryBot.create(:court_application_payment)
      court_application.court_centre_id = "6131bd34-33d9-3d1e-8152-8b5a2084f1bd"
      court_application.judicial_results << FactoryBot.create(:judicial_result_with_relationships)
      court_application.save!
    end

    it_has_behaviour "conforming to valid schema"
  end
end
