class BoxHearingRequest < ApplicationRecord
  include BuilderMappable
  include CourtCentreRelatable

  JURISDICTION_TYPES = %w[MAGISTRATES CROWN].freeze

  validates :court_centre_id, presence: true
  validates :application_due_date, presence: true
  validates :jurisdiction_type, presence: true

  def to_builder
    Jbuilder.new do |box_hearing_request|
      box_hearing_request.id id
      box_hearing_request.courtCentre court_centre.to_builder
      box_hearing_request.jurisdictionType jurisdiction_type
      box_hearing_request.applicationDueDate application_due_date
      box_hearing_request.virtualAppointmentTime virtual_appointment_time
      box_hearing_request.sendAppointmentLetter send_appointment_letter
    end
  end
end
