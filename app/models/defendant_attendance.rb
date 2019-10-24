# frozen_string_literal: true

class DefendantAttendance < ApplicationRecord
  belongs_to :defendant
  has_many :attendance_days

  validates :defendant_id, presence: true
  validates :attendance_days, presence: true

  def to_builder
    Jbuilder.new do |defendant_attendance|
      defendant_attendance.defendantId defendant_id
      defendant_attendance.attendanceDays attendance_days_builder
    end
  end

  private

  def attendance_days_builder
    attendance_days.map do |attendance_day|
      attendance_day.to_builder.attributes!
    end
  end
end
