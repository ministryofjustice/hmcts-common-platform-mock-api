# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate

  ERROR_MAPPINGS = {
    Errors::InvalidParams => :bad_request,
    ActiveRecord::RecordNotFound => :not_found,
    ActionController::ParameterMissing => :bad_request
  }.freeze

  ERROR_MAPPINGS.each do |klass, status|
    rescue_from klass do |error|
      render json: { error: error }, status: status
    end
  end

private

  def authenticate
    authenticated = ActiveSupport::SecurityUtils.secure_compare(
      request.headers.fetch("Ocp-Apim-Subscription-Key", ""),
      ENV.fetch("SHARED_SECRET_KEY"),
    )

    head :unauthorized unless authenticated
  end
end
