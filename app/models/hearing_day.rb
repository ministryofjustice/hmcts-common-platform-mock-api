# frozen_string_literal: true

class HearingDay < ApplicationRecord
  include BuilderMappable
  include CourtCentreRelatable

  validates :sittingDay, presence: true
  validates :listedDurationMinutes, presence: true

  has_many :events, class_name: 'HearingEvent', inverse_of: :hearing_day
  belongs_to :hearing, optional: true

  def to_builder
    Jbuilder.new do |hearing_day|
      hearing_day.sittingDay sittingDay
      hearing_day.startTime startTime
      hearing_day.listingSequence listingSequence
      hearing_day.listedDurationMinutes listedDurationMinutes
    end
  end
end
