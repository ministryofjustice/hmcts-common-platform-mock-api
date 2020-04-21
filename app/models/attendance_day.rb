# frozen_string_literal: true

class AttendanceDay < ApplicationRecord
  validates :day, presence: true
  validates :isInAttendance, inclusion: [true, false]
  validates :byVideoLinkFromCustodyLocation, inclusion: [true, false]

  def to_builder
    Jbuilder.new do |attendance_day|
      attendance_day.day day.to_date
      attendance_day.isInAttendance isInAttendance
      attendance_day.byVideoLinkFromCustodyLocation byVideoLinkFromCustodyLocation
    end
  end
end
