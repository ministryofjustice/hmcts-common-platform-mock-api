class FutureSummonsHearing < ApplicationRecord
  include BuilderMappable
  include CourtCentreRelatable

  JURISDICTION_TYPES = %w[MAGISTRATES CROWN].freeze

  has_many :judicial_roles

  def to_builder
    Jbuilder.new do |court_hearing_request|
      court_hearing_request.jurisdictionType jurisdiction_type
      court_hearing_request.earliestStartDateTime earliest_start_date_time
      court_hearing_request.weekCommencingDate week_commencing_date
      court_hearing_request.estimatedMinutes estimated_minutes
      court_hearing_request.courtCentre court_centre.to_builder
      court_hearing_request.judiciary array_builder(judicial_roles)
    end
  end
end
