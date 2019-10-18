# frozen_string_literal: true

class NextHearingDefendant < ApplicationRecord
  has_many :next_hearing_offences
  belongs_to :next_hearing_prosecution_case, optional: true, inverse_of: :next_hearing_defendants

  validates :next_hearing_offences, presence: true

  def to_builder
    Jbuilder.new do |next_hearing_defendant|
      next_hearing_defendant.id id
      next_hearing_defendant.offences Jbuilder.new.array! offences_builder
    end
  end

  private

  def offences_builder
    next_hearing_offences.map do |next_hearing_offence|
      next_hearing_offence.to_builder.attributes!
    end
  end
end
