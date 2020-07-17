# frozen_string_literal: true

RSpec.describe HearingEvent, type: :model do
  let(:hearing_event) { FactoryBot.create(:hearing_event) }

  let(:json_schema) { :hearing_event }

  subject { hearing_event }

  describe 'validations' do
    it { should validate_presence_of(:hearing) }
    it { should validate_presence_of(:hearingEventDefinitionId) }
    it { should validate_presence_of(:recordedLabel) }
    it { should validate_presence_of(:eventTime) }
  end

  describe 'relationships' do
    it { should belong_to(:hearing) }
  end

  it_has_a 'realistic factory'
end
