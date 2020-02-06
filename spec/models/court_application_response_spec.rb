# frozen_string_literal: true

RSpec.describe CourtApplicationResponse, type: :model do
  let(:court_application_response) { FactoryBot.create(:court_application_response) }

  let(:json_schema) { :court_application_response }

  subject { court_application_response }

  describe 'associations' do
    it { should belong_to(:application_response_type).class_name('CourtApplicationResponseType') }
  end

  describe 'validations' do
    it { should validate_presence_of(:originatingHearingId) }
    it { should validate_presence_of(:applicationId) }
    it { should validate_presence_of(:applicationResponseDate) }
    it { should validate_presence_of(:application_response_type) }
  end

  context 'hmcts schema' do
    it_has_behaviour 'conforming to valid schema'
  end
end
