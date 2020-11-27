# frozen_string_literal: true

class IndicatedPlea < ApplicationRecord
  VALUES = %w[INDICATED_GUILTY INDICATED_NOT_GUILTY NO_INDICATION].freeze
  SOURCES = %w[ONLINE IN_COURT].freeze

  belongs_to :hearing
  belongs_to :offence

  validates :indicatedPleaDate, presence: true
  validates :indicatedPleaValue, presence: true, inclusion: VALUES
  validates :source, presence: true, inclusion: SOURCES

  def to_builder
    Jbuilder.new do |indicated_plea|
      indicated_plea.offenceId offence_id
      indicated_plea.originatingHearingId hearing_id
      indicated_plea.indicatedPleaDate indicatedPleaDate.to_date
      indicated_plea.indicatedPleaValue indicatedPleaValue
      indicated_plea.source source
    end
  end
end
