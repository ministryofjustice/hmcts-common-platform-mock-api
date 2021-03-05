class ApplicationVerdict < ApplicationRecord

  belongs_to :verdict_type
  belongs_to :jurors
  belongs_to :lesser_or_alternative_offence

  validates :application_id, presence: true
  validates :verdict_date, presence: true
  validates :verdict_type, presence: true

  def to_builder
    Jbuilder.new do |application_verdict|
      application_verdict.originatingHearingId originating_hearing_id
      application_verdict.applicationId application_id
      application_verdict.verdictDate verdict_date
      application_verdict.verdictType verdict_type.to_builder
      application_verdict.jurors jurors.to_builder
      application_verdict.lesserOrAlternativeOffence lesser_or_alternative_offence.to_builder
    end
  end
end
