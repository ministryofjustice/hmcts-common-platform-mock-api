# frozen_string_literal: true

class Plea < ApplicationRecord
  VALUES = %w[GUILTY
              NOT_GUILTY
              MCA_GUILTY
              UNFIT_TO_PLEAD
              AUTREFOIS_ACQUIT
              AUTREFOIS_CONVICT
              CONSENTS
              OPPOSES
              NO_PLEA
              CHANGE_TO_NOT_GUILTY
              CHANGE_TO_GUILTY_AFTER_SWORN_IN
              CHANGE_TO_GUILTY_MAGISTRATES_COURT
              PARDON].freeze

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
