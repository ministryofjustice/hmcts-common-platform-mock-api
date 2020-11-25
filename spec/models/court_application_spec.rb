# frozen_string_literal: true

RSpec.describe CourtApplication, type: :model do
  let(:court_application) { FactoryBot.create(:court_application) }
  let(:json_schema) { :court_application }

  subject { court_application }

  describe 'associations' do
    it { should belong_to(:application_type).class_name('CourtApplicationType') }
    it { should belong_to(:court_application_party).class_name('CourtApplicationParty') }
    it { should belong_to(:court_application_outcome).class_name('CourtApplicationOutcome').optional }
    it { should belong_to(:court_application_payment).class_name('CourtApplicationPayment').optional }
    it { should have_many(:court_application_respondents).class_name('CourtApplicationRespondent') }
    it { should have_many(:judicial_results).class_name('JudicialResult') }
  end

  describe 'validations' do
    it { should validate_presence_of(:application_type) }
    it { should validate_presence_of(:applicationReceivedDate) }
    it { should validate_presence_of(:court_application_party) }
    it { should validate_presence_of(:applicationStatus) }
    it { should validate_inclusion_of(:applicationStatus).in_array(%w[DRAFT LISTED FINALISED]) }
  end

  it_has_behaviour 'conforming to valid schema'

  context 'hmcts schema' do
    before do
      court_application.court_application_respondents << FactoryBot.create(:court_application_respondent)
      court_application.court_application_outcome = FactoryBot.create(:court_application_outcome)
      court_application.court_application_payment = FactoryBot.create(:court_application_payment)
      court_application.court_centre_id = '6131bd34-33d9-3d1e-8152-8b5a2084f1bd'
      court_application.judicial_results << FactoryBot.create(:judicial_result_with_relationships)
      court_application.save!
    end
    it_has_behaviour 'conforming to valid schema'
  end
end
