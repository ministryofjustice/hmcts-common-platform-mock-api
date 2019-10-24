# frozen_string_literal: true

class DefenceCounsel < ApplicationRecord
  has_many :defendants
  has_many :attendance_days

  validates :defendants, presence: true
  validates :attendance_days, presence: true

  def to_builder
    Jbuilder.new do |defence_counsel|
      defence_counsel.id id
      defence_counsel.title title
      defence_counsel.firstName firstName
      defence_counsel.middleName middleName
      defence_counsel.lastName lastName
      defence_counsel.status status
      defence_counsel.defendants Jbuilder.new.array! defendants.ids
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
