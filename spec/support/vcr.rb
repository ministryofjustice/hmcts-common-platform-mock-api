# frozen_string_literal: true

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :faraday
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<LAA_ADAPTOR_URL>') { ENV['LAA_ADAPTOR_URL'] }
  c.filter_sensitive_data('<LAA_ADAPTOR_AUTH_TOKEN>') { ENV['LAA_ADAPTOR_AUTH_TOKEN'] }
end
