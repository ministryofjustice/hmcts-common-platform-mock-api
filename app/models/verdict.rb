class Verdict < ApplicationRecord
  belongs_to :verdict_type
  belongs_to :jurors, optional: true
  belongs_to :lesser_or_alternative_offence, optional: true

  validates :originatingHearingId, presence: true
  validates :offenceId, presence: true
  validates :verdictDate, presence: true
  validates :verdict_type, presence: true

  def to_builder
    Jbuilder.new do |verdict|
      verdict.originatingHearingId originatingHearingId
      verdict.offenceId offenceId
      verdict.verdictDate verdictDate.to_date
      verdict.verdictType verdict_type.to_builder
    end
    
  end
end
