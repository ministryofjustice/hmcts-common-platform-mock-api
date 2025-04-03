# frozen_string_literal: true

RSpec.describe CourtApplication, type: :model do
  subject { court_application }

  let(:court_application) { FactoryBot.create(:court_application) }
  let(:json_schema) { :court_application }

  describe "associations" do
    it { is_expected.to belong_to(:court_application_type).class_name("CourtApplicationType") }
    it { is_expected.to belong_to(:court_application_party).class_name("CourtApplicationParty") }
    it { is_expected.to belong_to(:court_application_payment).class_name("CourtApplicationPayment").optional }
    it { is_expected.to have_many(:judicial_results).class_name("JudicialResult") }
    it { is_expected.to have_many(:respondents).class_name("CourtApplicationParty") }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:applicationReceivedDate) }
    it { is_expected.to validate_presence_of(:court_application_party) }
    it { is_expected.to validate_presence_of(:applicationStatus) }
    it { is_expected.to validate_inclusion_of(:applicationStatus).in_array(%w[DRAFT LISTED FINALISED]) }
  end

  it_has_behaviour "conforming to valid schema"

  describe "hmcts schema" do
    before do
      court_application.court_application_payment = FactoryBot.create(:court_application_payment)
      court_application.judicial_results << FactoryBot.create(:judicial_result_with_relationships)
      court_application.save!
    end

    it_has_behaviour "conforming to valid schema"
  end

  it "generates a valid short ID on creation" do
    expect(court_application.short_code.length).to eq 12
    expect(court_application.short_code).to start_with("A")
  end
end
