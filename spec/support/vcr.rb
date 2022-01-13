# frozen_string_literal: true

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
  c.hook_into :faraday
  c.configure_rspec_metadata!
  c.filter_sensitive_data("<LAA_DEV_API_URL>") { ENV["LAA_DEV_API_URL"] }
  c.filter_sensitive_data("<LAA_DEV_CLIENT_ID>") { ENV["LAA_DEV_CLIENT_ID"] }
  c.filter_sensitive_data("<LAA_DEV_CLIENT_SECRET>") { ENV["LAA_DEV_CLIENT_SECRET"] }
  c.filter_sensitive_data("<LAA_DEV_OAUTH_URL>") { ENV["LAA_DEV_OAUTH_URL"] }
  c.filter_sensitive_data("<ACCESS_TOKEN>") do |interaction|
    JSON.parse(interaction.response.body)["access_token"] if interaction.response.body.present?
  end

  c.filter_sensitive_data("<BEARER_TOKEN>") do |interaction|
    interaction.request.headers["Authorization"]&.first
  end
end
