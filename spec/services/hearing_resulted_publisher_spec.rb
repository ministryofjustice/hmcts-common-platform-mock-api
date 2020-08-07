# frozen_string_literal: true

RSpec.describe HearingResultedPublisher do
  let(:hearing) { FactoryBot.create(:hearing, resulted: true) }
  let(:shared_time) { '2019-12-12T00:00:00+00:00' }

  subject { described_class.call(hearing_id: hearing.id, shared_time: shared_time) }

  context 'with invalid params' do
    let(:shared_time) { 'INVALID DATETIME' }

    it 'raises an invalid params error' do
      expect do
        subject
      end.to raise_error(Errors::InvalidParams)
    end
  end

  context 'with valid params' do
    before do
      WebMock.disable_net_connect!(allow: ENV['LAA_DEV_API_URL'])
    end

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

    subject { described_class.call(hearing_id: hearing.id, shared_time: shared_time) }

    it 'makes a POST request' do
      expect(connection).to receive(:post)
      subject
    end
  end
end
