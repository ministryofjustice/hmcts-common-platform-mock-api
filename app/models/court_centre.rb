class CourtCentre < ApplicationRecord
  belongs_to :address, optional: true

  def to_builder
    Jbuilder.new do |court_centre|
      court_centre.id id
      court_centre.name name
      court_centre.welshName welshName
      court_centre.roomId roomId
      court_centre.roomName roomName
      court_centre.welshRoomName welshRoomName
      court_centre.address address.to_builder if address.present?
    end
  end
end
