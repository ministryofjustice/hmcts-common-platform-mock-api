# frozen_string_literal: true

class AttendanceDay < ApplicationRecord
  TYPES = %w[IN_PERSON BY_VIDEO NOT_PRESENT].freeze

  validates :day, presence: true
  validates :attendanceType, inclusion: TYPES, presence: true

  def to_builder
    Jbuilder.new do |attendance_day|
      attendance_day.day day.to_date
      attendance_day.attendanceType attendanceType
    end
  end
end
