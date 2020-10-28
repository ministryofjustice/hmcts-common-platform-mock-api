# frozen_string_literal: true

RSpec.describe HearingResultedPublisher do
  let(:hearing) { FactoryBot.create(:hearing, resulted: true) }

  subject { described_class.call(hearing_id: hearing.id) }

  context 'with valid params' do
    it 'sends a payload to LAA hearings endpoint' do
      VCR.use_cassette('hearings/resulted/success') do
        expect(subject.status).to eq(202)
      end
    end
  end

  context 'connection' do
    let(:connection) { double('LaaConnector') }

    before do
      allow(LaaConnector).to receive(:call).and_return(connection)
    end

    subject { described_class.call(hearing_id: hearing.id) }

    it 'makes a POST request' do
      expect(connection).to receive(:post)
      subject
    end
  end
end
