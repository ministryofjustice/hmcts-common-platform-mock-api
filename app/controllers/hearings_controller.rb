# frozen_string_literal: true

class HearingsController < ApplicationController
  def show
    @hearing = HearingFinder.call(params)

    render json: @hearing.to_builder.attributes!
  end

  def log
    @hearing_events = HearingLogFinder.call(params)

    render json: hearing_log_response
  end

  private

  def hearing_log_response
    {
      "hearingId": params[:hearingId],
      "hasActiveHearing": @hearing_events.present?,
      "events": hearing_events_builder
    }
  end

  def hearing_events_builder
    @hearing_events.map do |event|
      {
        "hearingEventId": event.id,
        "hearingEventDefinitionId": event.hearingEventDefinitionId,
        "recordedLabel": event.recordedLabel,
        "eventTime": event.eventTime.to_datetime,
        "lastModifiedTime": event.updated_at.to_datetime,
        "alterable": event.alterable
      }
    end
  end
end
