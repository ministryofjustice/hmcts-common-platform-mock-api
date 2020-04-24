# frozen_string_literal: true

class HearingsController < ApplicationController
  def show
    @hearing = HearingFinder.call(params)

    render json: @hearing.to_builder.attributes!
  end

  def log
    @hearing = HearingLogFinder.call(params)

    render json: hearing_log_response
  end

  private

  def hearing_log_response
    { hearingLog: hearing_events_builder }
  end

  def hearing_events_builder
    @hearing.events.map do |event|
      event.to_builder.attributes!
    end
  end

  def authenticate
    authenticated = ActiveSupport::SecurityUtils.secure_compare(
      request.headers.fetch('Ocp-Apim-Subscription-Key', ''),
      ENV.fetch('SHARED_SECRET_KEY_HEARING')
    )

    head :unauthorized unless authenticated
  end
end
