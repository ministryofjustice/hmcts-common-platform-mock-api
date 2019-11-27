# frozen_string_literal: true

class NextHearingProsecutionCase < ApplicationRecord
  include BuilderMappable
  has_many :next_hearing_defendants

  belongs_to :next_hearing, optional: true, inverse_of: :next_hearing_prosecution_cases

  validates :next_hearing_defendants, presence: true

  def to_builder
    Jbuilder.new do |next_hearing_prosecution_case|
      next_hearing_prosecution_case.id id
      next_hearing_prosecution_case.defendants array_builder(next_hearing_defendants)
    end
  end
end
