# frozen_string_literal: true

RSpec.describe CourtApplicationOutcome, type: :model do
  let(:court_application_outcome) { FactoryBot.create(:court_application_outcome) }

  let(:json_schema) { :court_application_outcome }

  subject { court_application_outcome }

  describe 'associations' do
    it { should belong_to(:application_outcome_type).class_name('CourtApplicationOutcomeType') }
  end

  describe 'validations' do
    it { should validate_presence_of(:originatingHearingId) }
    it { should validate_presence_of(:applicationId) }
    it { should validate_presence_of(:application_outcome_type) }
    it { should validate_presence_of(:applicationOutcomeDate) }
  end

  context 'hmcts schema' do
    it_has_behaviour 'conforming to valid schema'
  end
end
