# frozen_string_literal: true

class CourtApplicationPartyAttendance < ApplicationRecord
  belongs_to :court_application_party
  has_many :attendance_days

  validates :court_application_party, presence: true
  validates :attendance_days, presence: true

  def to_builder
    Jbuilder.new do |court_application_party_attendance|
      court_application_party_attendance.courtApplicationPartyId court_application_party_id
      court_application_party_attendance.attendanceDays attendance_days_builder
    end
  end

  private

  def attendance_days_builder
    attendance_days.map do |attendance_day|
      attendance_day.to_builder.attributes!
    end
  end
end
