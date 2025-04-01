# frozen_string_literal: true

RSpec.describe HearingLogFinder do
  subject(:find_hearing) { described_class.call(params) }

  let(:params) { ActionController::Parameters.new(params_hash) }

  context "with invalid params" do
    let(:params_hash) do
      { random: "value" }
    end

    it "raises an invalid params error" do
      expect {
        find_hearing
      }.to raise_error(Errors::InvalidParams)
    end
  end

  context "when finding by hearingId" do
    let(:hearing) { FactoryBot.create(:hearing) }
    let(:hearing_event) { FactoryBot.create(:hearing_event, hearing_day: hearing.hearing_days.first) }

    let(:params_hash) do
      { hearingId: hearing.hearing_id, date: "2019-10-23" }
    end

    it { is_expected.to eq([hearing_event]) }

    context "with an incorrect id" do
      let(:params_hash) do
        { hearingId: "6c0b7068-d4a7-4adc-a7a0-7bd5715b501d", date: "2019-10-23" }
      end

      it "raises a RecordNotFound error" do
        expect {
          find_hearing
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
