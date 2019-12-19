# frozen_string_literal: true

module AuthorisedRequestHelper
  def authorise_requests!
    allow(controller).to receive(:authenticate).and_return(true)
  end

  def valid_auth_header
    { 'Authorization': "Bearer #{ENV.fetch('COMMON_PLATFORM_SHARED_SECRET_KEY')}" }
  end
end
