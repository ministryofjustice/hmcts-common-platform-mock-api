# frozen_string_literal: true

class CourtApplicationPartyCounsel < ApplicationRecord
  has_many :court_application_parties
  has_many :attendance_days

  validates :applicationId, presence: true
  validates :attendance_days, presence: true

  def to_builder
    Jbuilder.new do |defence_counsel|
      defence_counsel.id id
      defence_counsel.applicationId applicationId
      defence_counsel.title title
      defence_counsel.firstName firstName
      defence_counsel.middleName middleName
      defence_counsel.lastName lastName
      defence_counsel.status status
      defence_counsel.applicationRespondents Jbuilder.new.array! court_application_parties.ids if court_application_parties.present?
      defence_counsel.attendanceDays Jbuilder.new.array! attendance_days_builder
    end
  end

  private

  def attendance_days_builder
    attendance_days.map do |attendance_day|
      attendance_day.day.to_date
    end
  end
end
