# frozen_string_literal: true

class Plea < ApplicationRecord
  VALUES = %w[GUILTY NOT_GUILTY].freeze

  belongs_to :delegated_powers, optional: true

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
      plea.delegatedPowers delegated_powers.to_builder if delegated_powers.present?
    end
  end
end
