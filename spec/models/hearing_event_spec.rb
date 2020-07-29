# frozen_string_literal: true

RSpec.describe HearingEvent, type: :model do
  let(:hearing) { FactoryBot.create(:hearing) }
  let(:hearing_event) { FactoryBot.create(:hearing_event, hearing_day: hearing.hearing_days.first) }

  let(:json_schema) { :hearing_event }

  subject { hearing_event }

  describe 'validations' do
    it { should validate_presence_of(:hearing_day) }
    it { should validate_presence_of(:hearingEventDefinitionId) }
    it { should validate_presence_of(:recordedLabel) }
    it { should validate_presence_of(:eventTime) }
  end

  describe 'relationships' do
    it { should belong_to(:hearing_day) }
  end

  it_has_a 'realistic factory'
end
