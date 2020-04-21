# frozen_string_literal: true

class InterpreterIntermediary < ApplicationRecord
  ROLES = %w[INTERPRETER INTERMEDIARY].freeze
  belongs_to :attendant
  has_many :attendance_days

  validates :role, presence: true, inclusion: ROLES
  validates :firstName, presence: true
  validates :lastName, presence: true
  validates :attendant, presence: true
  validates :attendance_days, presence: true

  def to_builder
    Jbuilder.new do |interpreter_intermediary|
      interpreter_intermediary.id id
      interpreter_intermediary.role role
      interpreter_intermediary.firstName firstName
      interpreter_intermediary.lastName lastName
      interpreter_intermediary.attendant attendant.to_builder
      interpreter_intermediary.attendanceDays attendance_days_builder
    end
  end

  private

  def attendance_days_builder
    attendance_days.map do |attendance_day|
      attendance_day.day.to_date
    end
  end
end
