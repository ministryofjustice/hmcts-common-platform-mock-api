class Plea < ApplicationRecord
  VALUES = %w(GUILTY NOT_GUILTY)

  has_one :delegated_powers, as: :delegated_powerable

  validates :originatingHearingId, presence: true
  validates :offenceId, presence: true
  validates :pleaDate, presence: true
  validates :pleaValue, presence: true, inclusion: VALUES

  def to_builder
    Jbuilder.new do |plea|
      plea.originatingHearingId originatingHearingId
      plea.offenceId offenceId
      plea.pleaDate pleaDate.to_date
      plea.pleaValue pleaValue
    end
  end
end
