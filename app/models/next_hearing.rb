class NextHearing < ApplicationRecord
  belongs_to :hearing_type
  belongs_to :court_centre

  validates :hearing_type, presence: true
  validates :court_centre, presence: true
  validates :estimatedMinutes, presence: true
  validates :listedStartDateTime, presence: true
  validates :jurisdictionType, inclusion: %w(MAGISTRATES CROWN)
  validates :hearingLanguage, inclusion: %w(ENGLISH WELSH)

  def to_builder
    Jbuilder.new do |next_hearing|
      next_hearing.type hearing_type.to_builder
      next_hearing.courtCentre court_centre.to_builder
      next_hearing.estimatedMinutes estimatedMinutes
      next_hearing.listedStartDateTime listedStartDateTime
    end
  end
end
