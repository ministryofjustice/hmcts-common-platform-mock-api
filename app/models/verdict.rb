# frozen_string_literal: true

class Verdict < ApplicationRecord
  belongs_to :verdict_type
  belongs_to :jurors, optional: true
  belongs_to :lesser_or_alternative_offence, optional: true

  belongs_to :hearing
  belongs_to :offence

  validates :verdictDate, presence: true
  validates :verdict_type, presence: true
  validates :application_id, presence: true, if: -> { offence_id.blank? }
  validates :offence_id, presence: true, if: -> { application_id.blank? }

  def to_builder
    Jbuilder.new do |verdict|
      verdict.originatingHearingId hearing_id
      verdict.offenceId offence_id
      verdict.applicationId application_id
      verdict.verdictDate verdictDate.to_date
      verdict.verdictType verdict_type.to_builder
      verdict.jurors jurors.to_builder if jurors.present?
      verdict.lesserOrAlternativeOffence lesser_or_alternative_offence.to_builder if lesser_or_alternative_offence.present?
    end
  end
end
