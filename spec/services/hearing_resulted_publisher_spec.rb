# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HearingResultedPublisher do
  let(:hearing) { FactoryBot.create(:hearing) }
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
      WebMock.disable_net_connect!(allow: ENV.fetch('LAA_ADAPTOR_URL'))
    end

    it 'POSTs to hearings endpoint on the LAA adaptor' do
      VCR.use_cassette('hearings/resulted/success') do
        expect(subject.status).to eq(201)
      end
    end
  end
end
