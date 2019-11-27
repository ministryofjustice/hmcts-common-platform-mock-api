# frozen_string_literal: true

class NextHearing < ApplicationRecord
  include BuilderMappable
  belongs_to :hearing_type
  belongs_to :court_centre

  has_many :judicial_roles
  has_many :next_hearing_prosecution_cases
  has_many :next_hearing_court_applications

  validates :hearing_type, presence: true
  validates :court_centre, presence: true
  validates :estimatedMinutes, presence: true
  validates :listedStartDateTime, presence: true
  validates :jurisdictionType, inclusion: %w[MAGISTRATES CROWN]
  validates :hearingLanguage, inclusion: %w[ENGLISH WELSH]

  def to_builder
    Jbuilder.new do |next_hearing|
      next_hearing.type hearing_type.to_builder
      next_hearing.courtCentre court_centre.to_builder
      next_hearing.estimatedMinutes estimatedMinutes
      next_hearing.listedStartDateTime listedStartDateTime
      next_hearing.jurisdictionType jurisdictionType
      next_hearing.reportingRestrictionReason reportingRestrictionReason
      next_hearing.adjournmentReason adjournmentReason
      next_hearing.hearingLanguage hearingLanguage
      next_hearing.judiciary array_builder(judicial_roles)
      next_hearing.nextHearingProsecutionCases array_builder(next_hearing_prosecution_cases)
      next_hearing.nextHearingCourtApplicationId collection_ids(next_hearing_court_applications)
    end
  end
end
