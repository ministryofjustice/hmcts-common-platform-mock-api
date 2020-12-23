# frozen_string_literal: true

class HearingEvent < ApplicationRecord
  validates :hearing_day, presence: true
  validates :hearingEventDefinitionId, presence: true
  validates :recordedLabel, presence: true
  validates :eventTime, presence: true

  belongs_to :hearing_day, inverse_of: :events

  def to_builder
    Jbuilder.new do |hearing_event|
      hearing_event.hearingEventId id
      hearing_event.hearingEventDefinitionId hearingEventDefinitionId
      hearing_event.recordedLabel recordedLabel
      hearing_event.eventTime event_time.to_datetime
      hearing_event.lastModifiedTime updated_at.to_datetime
      hearing_event.alterable alterable
    end
  end

private

  def event_time
    day = hearing_day.sittingDay
    eventTime.change(year: day.year, month: day.month, day: day.day)
  end
end
