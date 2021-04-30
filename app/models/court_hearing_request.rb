class CourtHearingRequest < ApplicationRecord
  include BuilderMappable
  include CourtCentreRelatable

  JURISDICTION_TYPES = %w[MAGISTRATES CROWN].freeze

  belongs_to :hearing_type
  has_many :rota_slots
  has_many :judicial_roles

  def to_builder
    Jbuilder.new do |court_hearing_request|
      court_hearing_request.hearingType hearing_type.to_builder
      court_hearing_request.jurisdictionType jurisdiction_type
      court_hearing_request.listedStartDateTime listed_start_date_time
      court_hearing_request.earliestStartDateTime earliest_start_date_time
      court_hearing_request.endDate end_date
      court_hearing_request.bookingReference booking_reference
      court_hearing_request.weekCommencingDate week_commencing_date
      court_hearing_request.bookedSlots array_builder(rota_slots)
      court_hearing_request.estimateMinutes estimate_minutes
      court_hearing_request.courtCentre court_centre.to_builder
      court_hearing_request.listingDirections listing_directions
      court_hearing_request.judiciary array_builder(judicial_roles)
    end
  end
end
