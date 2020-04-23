# frozen_string_literal: true

class HearingEvent < ApplicationRecord
  validates :hearing, presence: true
  validates :hearingEventDefinitionId, presence: true
  validates :recordedLabel, presence: true
  validates :eventTime, presence: true

  belongs_to :hearing, inverse_of: :events

  def to_builder
    Jbuilder.new do |hearing_event|
      hearing_event.hearingId hearing_id
      hearing_event.hearingEventDefinitionId hearingEventDefinitionId
      hearing_event.recordedLabel recordedLabel
      hearing_event.eventTime eventTime.to_datetime
    end
  end
end
