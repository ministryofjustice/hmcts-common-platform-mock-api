# frozen_string_literal: true

RSpec.describe HearingResulter do
  subject(:result_and_publish) { described_class.call(hearing_id: hearing.id, publish_to:) }

  let(:hearing) { FactoryBot.create(:hearing) }
  let(:publish_to) { "dev" }

  before { allow(HearingResultedPublisher).to receive(:call) }

  it "triggers the publisher" do
    expect(HearingResultedPublisher).to receive(:call).with(hearing_id: hearing.id, type: "dev")
    result_and_publish
  end

  it "results the hearing" do
    result_and_publish
    expect(hearing.reload.resulted).to eq(true)
  end

  it "returns a boolean" do
    expect(result_and_publish).to eq(true)
  end

  context "when publish_to is nil" do
    let(:publish_to) { nil }

    it "does not trigger the publisher" do
      expect(HearingResultedPublisher).not_to receive(:call)
      result_and_publish
    end
  end

  context "when publish_to is invalid" do
    let(:publish_to) { "production" }

    it "does not trigger the publisher" do
      expect(HearingResultedPublisher).not_to receive(:call)
      result_and_publish
    end
  end
end
