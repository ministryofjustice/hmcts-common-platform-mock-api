# frozen_string_literal: true

RSpec.describe HearingEvent, type: :model do
  subject { hearing_event }

  let(:hearing) { FactoryBot.create(:hearing) }
  let(:hearing_event) { FactoryBot.create(:hearing_event, hearing_day: hearing.hearing_days.first) }

  let(:json_schema) { :hearing_event }

  describe "validations" do
    it { is_expected.to validate_presence_of(:hearing_day) }
    it { is_expected.to validate_presence_of(:hearingEventDefinitionId) }
    it { is_expected.to validate_presence_of(:recordedLabel) }
    it { is_expected.to validate_presence_of(:eventTime) }
  end

  describe "relationships" do
    it { is_expected.to belong_to(:hearing_day) }
  end

  it_has_a "realistic factory"
end
