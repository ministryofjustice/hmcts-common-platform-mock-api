# frozen_string_literal: true

RSpec.describe LaaConnector do
  subject(:call) { described_class.call(api_url:, client_id:, client_secret:) }

  let(:api_url) { "API_URL" }
  let(:client_id) { "CLIENT_ID" }
  let(:client_secret) { "CLIENT_SECRET" }

  it "connects to the laa api url" do
    expect(Faraday).to receive(:new).with(api_url)
    call
  end

  context "with faraday configuration" do
    let(:connection) { double }
    let(:oauth_client) { instance_double(OAuth2::Client, client_credentials: token_generator) }
    let(:token_generator) { double(get_token: double(token: "XYZ")) }

    before do
      allow(Faraday).to receive(:new).and_yield(connection)
      allow(OAuth2::Client).to receive(:new).and_return(oauth_client)
    end

    it "authenticates with generated oauth token" do
      expect(OAuth2::Client).to receive(:new).with(client_id, client_secret, site: api_url)
      expect(connection).to receive(:request).with(:authorization, "Bearer", "XYZ")
      expect(connection).to receive(:request)
      expect(connection).to receive(:response).with(:json, content_type: "application/json")
      expect(connection).to receive(:adapter).with(:net_http)
      call
    end
  end
end
