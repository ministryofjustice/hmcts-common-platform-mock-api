# frozen_string_literal: true

class HearingsController < ApplicationController
  def show
    @hearing = HearingFinder.call(params)

    render json: @hearing.to_builder.attributes!
  end

  private

  def authenticate
    authenticated = ActiveSupport::SecurityUtils.secure_compare(
      request.headers.fetch('Ocp-Apim-Subscription-Key', ''),
      ENV.fetch('SHARED_SECRET_KEY_HEARING')
    )

    head :unauthorized unless authenticated
  end
end
