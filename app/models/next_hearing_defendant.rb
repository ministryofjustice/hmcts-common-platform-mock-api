# frozen_string_literal: true

class NextHearingDefendant < ApplicationRecord
  include BuilderMappable
  has_many :next_hearing_offences
  belongs_to :next_hearing_prosecution_case, optional: true, inverse_of: :next_hearing_defendants

  validates :next_hearing_offences, presence: true

  def to_builder
    Jbuilder.new do |next_hearing_defendant|
      next_hearing_defendant.id id
      next_hearing_defendant.offences array_builder(next_hearing_offences)
    end
  end
end
