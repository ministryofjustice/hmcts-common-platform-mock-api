# frozen_string_literal: true

class ApplicantCounsel < ApplicationRecord
  has_many :applicants
  has_many :attendance_days

  validates :applicants, presence: true
  validates :attendance_days, presence: true

  def to_builder
    Jbuilder.new do |applicant_counsel|
      applicant_counsel.id id
      applicant_counsel.title title
      applicant_counsel.firstName firstName
      applicant_counsel.middleName middleName
      applicant_counsel.lastName lastName
      applicant_counsel.status status
      applicant_counsel.applicants Jbuilder.new.array! applicants.ids
      applicant_counsel.attendanceDays Jbuilder.new.array! attendance_days_builder
    end
  end

  private

  def attendance_days_builder
    attendance_days.map do |attendance_day|
      attendance_day.day.to_date
    end
  end
end
