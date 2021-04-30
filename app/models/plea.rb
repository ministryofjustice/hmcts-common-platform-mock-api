# frozen_string_literal: true

class Plea < ApplicationRecord
  include BuilderMappable

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
  belongs_to :lesser_or_alternative_offence, optional: true

  validates :pleaDate, presence: true
  validates :pleaValue, presence: true, inclusion: VALUES
  validates :offence_id, presence: true, if: -> { application_id.blank? }
  validates :application_id, presence: true, if: -> { offence_id.blank? }

  def to_builder
    Jbuilder.new do |plea|
      plea.originatingHearingId hearing_id
      plea.offenceId offence_id
      plea.pleaDate pleaDate.to_date
      plea.pleaValue pleaValue
      plea.delegatedPowers delegated_powers.to_builder if delegated_powers.present?
      plea.applicationId application_id
      plea.lesserOrAlternativeOffence lesser_or_alternative_offence.to_builder if lesser_or_alternative_offence.present?
    end
  end
end
