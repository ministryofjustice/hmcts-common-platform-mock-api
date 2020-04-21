# frozen_string_literal: true

class CompanyRepresentative < ApplicationRecord
  include BuilderMappable

  POSITIONS = %w[DIRECTOR SECRETARY].freeze
  has_many :defendants
  has_many :attendance_days

  validates :position, presence: true, inclusion: POSITIONS
  validates :firstName, presence: true
  validates :lastName, presence: true
  validates :defendants, presence: true
  validates :attendance_days, presence: true

  def to_builder
    Jbuilder.new do |company_representative|
      company_representative.id id
      company_representative.title title
      company_representative.firstName firstName
      company_representative.lastName lastName
      company_representative.position position
      company_representative.defendants collection_ids(defendants)
      company_representative.attendanceDays attendance_days_builder
    end
  end

  private

  def attendance_days_builder
    attendance_days.map do |attendance_day|
      attendance_day.day.to_date
    end
  end
end
