# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate

  ERROR_MAPPINGS = {
    Errors::InvalidParams => :bad_request,
    ActiveRecord::RecordNotFound => :not_found
  }.freeze

  ERROR_MAPPINGS.each do |klass, status|
    rescue_from klass do |error|
      render json: { error: error }, status: status
    end
  end

  private

  def authenticate
    authenticated = authenticate_with_http_token do |token|
      ActiveSupport::SecurityUtils.secure_compare(token, ENV.fetch('COMMON_PLATFORM_SHARED_SECRET_KEY'))
    end

    head :unauthorized unless authenticated
  end
end
