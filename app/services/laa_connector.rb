# frozen_string_literal: true

class LaaConnector < ApplicationService
  def initialize(api_url:, client_id:, client_secret:, oauth_url:)
    @api_url = api_url
    @client = OAuth2::Client.new(client_id, client_secret, site: oauth_url)
  end

  def call
    Faraday.new api_url do |connection|
      connection.request :oauth2, token.token, token_type: :bearer
      connection.request :json
      connection.response :json, content_type: 'application/json'
      connection.adapter Faraday.default_adapter
    end
  end

  private

  def token
    @token = client.client_credentials.get_token if @token.blank? || @token.expired?
  end

  attr_reader :api_url, :client
end
