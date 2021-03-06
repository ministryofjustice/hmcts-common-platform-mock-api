# frozen_string_literal: true

class ProsecutionCounsel < ApplicationRecord
  include BuilderMappable
  has_many :prosecution_cases, dependent: :nullify
  has_many :attendance_days, dependent: :destroy

  validates :prosecution_cases, presence: true
  validates :attendance_days, presence: true

  def to_builder
    Jbuilder.new do |applicant_counsel|
      applicant_counsel.id id
      applicant_counsel.title title
      applicant_counsel.firstName firstName
      applicant_counsel.middleName middleName
      applicant_counsel.lastName lastName
      applicant_counsel.status status
      applicant_counsel.prosecutionCases collection_ids(prosecution_cases)
      applicant_counsel.attendanceDays attendance_days_builder
    end
  end

private

  def attendance_days_builder
    attendance_days.map do |attendance_day|
      attendance_day.day.to_date
    end
  end
end
