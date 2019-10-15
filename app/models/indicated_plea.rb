class IndicatedPlea < ApplicationRecord
  VALUES = %w(INDICATED_GUILTY INDICATED_NOT_GUILTY NO_INDICATION)
  SOURCES = %w(ONLINE IN_COURT)

  validates :offenceId, presence: true
  validates :indicatedPleaDate, presence: true
  validates :indicatedPleaValue, presence: true, inclusion: VALUES
  validates :source, presence: true, inclusion: SOURCES

  def to_builder
    Jbuilder.new do |indicated_plea|
      indicated_plea.offenceId offenceId
      indicated_plea.indicatedPleaDate indicatedPleaDate.to_date
      indicated_plea.indicatedPleaValue indicatedPleaValue
      indicated_plea.source source
    end
  end
end