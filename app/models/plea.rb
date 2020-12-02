# frozen_string_literal: true

class Plea < ApplicationRecord
  VALUES = %w[GUILTY NOT_GUILTY].freeze

  belongs_to :delegated_powers, optional: true

  belongs_to :hearing
  belongs_to :offence

  validates :pleaDate, presence: true
  validates :pleaValue, presence: true, inclusion: VALUES

  def to_builder
    Jbuilder.new do |plea|
      plea.originatingHearingId hearing_id
      plea.offenceId offence_id
      plea.pleaDate pleaDate.to_date
      plea.pleaValue pleaValue
      plea.delegatedPowers delegated_powers.to_builder if delegated_powers.present?
    end
  end
end
