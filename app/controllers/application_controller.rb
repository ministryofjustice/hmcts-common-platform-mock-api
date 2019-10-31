# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from Errors::InvalidParams do |error|
    render json: { error: error }, status: :bad_request
  end
end
