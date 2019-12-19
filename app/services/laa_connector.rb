# frozen_string_literal: true

class LaaConnector < ApplicationService
  def initialize(connection_url: ENV.fetch('LAA_ADAPTOR_URL'), auth_token: ENV.fetch('LAA_ADAPTOR_AUTH_TOKEN'))
    @connection_url = connection_url
    @auth_token = auth_token
  end

  def call
    Faraday.new connection_url do |connection|
      connection.token_auth(auth_token)
      connection.request :json
      connection.response :json, content_type: 'application/json'
      connection.adapter Faraday.default_adapter
    end
  end

  private

  attr_reader :auth_token, :connection_url
end
