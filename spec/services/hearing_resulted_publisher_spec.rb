# frozen_string_literal: true

RSpec.describe HearingResultedPublisher do
  subject { described_class.call(hearing_id: hearing.id) }

  let(:hearing) { FactoryBot.create(:hearing, resulted: true) }

  context "with valid params" do
    it "sends a payload to LAA hearings endpoint" do
      VCR.use_cassette("hearings/resulted/success") do
        expect(subject.status).to eq(202)
      end
    end
  end

  context "connection" do
    subject { described_class.call(hearing_id: hearing.id) }

    let(:connection) { double("LaaConnector") }

    before do
      allow(LaaConnector).to receive(:call).and_return(connection)
    end

    it "makes a POST request" do
      expect(connection).to receive(:post)
      subject
    end
  end
end
