# frozen_string_literal: true

class HearingsController < ApplicationController
  def show
    @hearing = HearingFinder.call(params)

    render json: hearing_response
  end

  def log
    @hearing_events = HearingLogFinder.call(params)

    render json: hearing_log_response
  end

private

  # :nocov:
  def hearing_response
    return {} if @hearing.blank?

    @hearing.resulted_response
  end

  # :nocov:
  def hearing_log_response
    {
      "hearingId": params[:hearingId],
      "hasActiveHearing": @hearing_events.present?,
      "events": hearing_events_builder,
    }
  end

  def hearing_events_builder
    @hearing_events.map { |event| event.to_builder.attributes! }
  end
end
