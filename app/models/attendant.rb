# frozen_string_literal: true

class Attendant < ApplicationRecord
  ATTENDANT_TYPES = %w[DEFENDANTS WITNESS].freeze
  validates :attendantType, presence: true, inclusion: ATTENDANT_TYPES
  belongs_to :defendant, optional: true

  def to_builder
    Jbuilder.new do |attendant|
      attendant.attendantType attendantType
      attendant.name name if defendant.blank?
      attendant.defendantId defendant_id
    end
  end
end
