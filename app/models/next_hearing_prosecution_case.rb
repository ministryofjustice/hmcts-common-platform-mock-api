# frozen_string_literal: true

class NextHearingProsecutionCase < ApplicationRecord
  has_many :next_hearing_defendants

  belongs_to :next_hearing, optional: true, inverse_of: :next_hearing_prosecution_cases

  validates :next_hearing_defendants, presence: true

  def to_builder
    Jbuilder.new do |next_hearing_prosecution_case|
      next_hearing_prosecution_case.id id
      next_hearing_prosecution_case.defendants Jbuilder.new.array! defendants_builder
    end
  end

  private

  def defendants_builder
    next_hearing_defendants.map do |next_hearing_offence|
      next_hearing_offence.to_builder.attributes!
    end
  end
end
