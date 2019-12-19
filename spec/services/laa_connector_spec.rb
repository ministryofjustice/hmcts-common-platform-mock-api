# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LaaConnector do
  let(:laa_adaptor_url) { 'https://example.org' }
  let(:auth_token) { 'AUTH TOKEN' }
  let(:connection_double) { double('Faraday') }

  subject { described_class.call(connection_url: laa_adaptor_url, auth_token: auth_token) }

  it 'connects to the common platform url' do
    expect(Faraday).to receive(:new).with(laa_adaptor_url)
    subject
  end

  context 'faraday configuration' do
    let(:connection) { double }

    before do
      allow(Faraday).to receive(:new).and_yield(connection)
    end

    it 'authenticates with token auth' do
      expect(connection).to receive(:token_auth).with(auth_token)
      expect(connection).to receive(:request).with(:json)
      expect(connection).to receive(:response).with(:json, content_type: 'application/json')
      expect(connection).to receive(:adapter).with(:net_http)
      subject
    end
  end
end
