# frozen_string_literal: true

RSpec.describe ProsecutionConclusionPublisher do
  subject(:publisher) { described_class.call(prosecution_case_id: prosecution_case.id) }

  let(:prosecution_case) { FactoryBot.create(:prosecution_case) }

  context "with valid params" do
    before do
      prosecution_case.defendants.first.offences.first.pleas << FactoryBot.create(:plea)
      prosecution_case.defendants.first.offences.first.verdicts << FactoryBot.create(:verdict)
    end

    it "sends a payload to LAA hearings endpoint" do
      VCR.use_cassette("prosecution_cases/concluded/success") do
        expect(publisher.status).to eq(202)
      end
    end
  end

  context "with connection" do
    subject(:call_publisher) { described_class.call(prosecution_case_id: prosecution_case.id) }

    let(:connection) { double("LaaConnector") }

    before do
      allow(LaaConnector).to receive(:call).and_return(connection)
    end

    it "makes a POST request" do
      expect(connection).to receive(:post)
      call_publisher
    end
  end
end
