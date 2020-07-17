# frozen_string_literal: true

class HearingDay < ApplicationRecord
  include BuilderMappable
  include CourtCentreRelatable

  validates :sittingDay, presence: true
  validates :listedDurationMinutes, presence: true
  validate :end_time_cannot_be_before_start_time

  has_many :judicial_roles

  def to_builder
    Jbuilder.new do |hearing_day|
      hearing_day.sittingDay sittingDay
      hearing_day.listingSequence listingSequence
      hearing_day.listedDurationMinutes listedDurationMinutes
      hearing_day.startTime startTime.strftime('%H:%M:%S') if startTime.present?
      hearing_day.endTime endTime.strftime('%H:%M:%S') if endTime.present?
      hearing_day.actualDurationMinutes actual_duration_minutes
      hearing_day.onTheDayCourtRoomId onTheDayCourtRoomId
      hearing_day.onTheDayCourtCentre court_centre.to_builder if court_centre.present?
      hearing_day.onTheDayJudiciary array_builder(judicial_roles)
    end
  end

  private

  def actual_duration_minutes
    return nil if startTime.blank? || endTime.blank?

    (endTime - startTime).to_i
  end

  def end_time_cannot_be_before_start_time
    return if actual_duration_minutes.blank? || actual_duration_minutes.positive?

    errors.add(:endTime, "can't be before startTime")
  end
end
