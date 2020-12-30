# frozen_string_literal: true

class BoxHearingRequest < ApplicationRecord
  include CourtCentreRelatable

  validates :jurisdictionType, presence: true, inclusion: %w[CROWN MAGISTRATES]
  validates :court_centre_id, presence: true
  validates :applicationDueDate, presence: true

  def to_builder
    Jbuilder.new do |box_hearing_request|
      box_hearing_request.jurisdictionType jurisdictionType
      box_hearing_request.courtCentre court_centre
      box_hearing_request.applicationDueDate applicationDueDate.to_datetime
      box_hearing_request.virtualAppointmentTime virtualAppointmentTime.to_datetime
      box_hearing_request.sendAppointmentLetter sendAppointmentLetter
    end
  end
end
