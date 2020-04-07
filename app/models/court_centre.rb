# frozen_string_literal: true

class CourtCentre < ApplicationRecord
  belongs_to :address, optional: true
  belongs_to :lja_details, optional: true
  has_many :hearing_day

  def to_builder
    Jbuilder.new do |court_centre|
      court_centre.id id
      court_centre.name name
      court_centre.ouCode ouCode
      court_centre.courtHearingLocation courtHearingLocation
      court_centre.welshName welshName
      court_centre.roomId roomId
      court_centre.roomName roomName
      court_centre.welshRoomName welshRoomName
      court_centre.address address.to_builder if address.present?
      court_centre.lja lja_details.to_builder if lja_details.present?
    end
  end
end
