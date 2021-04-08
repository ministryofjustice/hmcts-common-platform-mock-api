# frozen_string_literal: true

class RespondentCounsel < ApplicationRecord
  include BuilderMappable

  has_many :attendance_days

  validates :respondents, presence: true
  validates :attendance_days, presence: true

  def to_builder
    Jbuilder.new do |respondent_counsel|
      respondent_counsel.id id
      respondent_counsel.title title
      respondent_counsel.firstName firstName
      respondent_counsel.middleName middleName
      respondent_counsel.lastName lastName
      respondent_counsel.status status
      respondent_counsel.respondents respondents
      respondent_counsel.attendanceDays attendance_days_builder
    end
  end

private

  def attendance_days_builder
    attendance_days.map do |attendance_day|
      attendance_day.day.to_date
    end
  end
end
