# frozen_string_literal: true

class DefenceCounsel < ApplicationRecord
  include BuilderMappable
  has_many :defendants, dependent: :nullify
  has_many :attendance_days, dependent: :destroy

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
      defence_counsel.defendants collection_ids(defendants)
      defence_counsel.attendanceDays attendance_days_builder
    end
  end

  private

  def attendance_days_builder
    attendance_days.map do |attendance_day|
      attendance_day.day.to_date
    end
  end
end
