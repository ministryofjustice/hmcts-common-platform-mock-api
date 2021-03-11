class RotaSlot < ApplicationRecord
  SESSIONS = ["All Day (AD)", "Morning (AM)", "Afternoon (PM)"].freeze

  validates :start_time, presence: true

  def to_builder
    Jbuilder.new do |rota_slot|
      rota_slot.startTime start_time
      rota_slot.duration duration
      rota_slot.courtScheduleId court_schedule_id
      rota_slot.session session
      rota_slot.oucode oucode
      rota_slot.courtRoomId court_room_id
      rota_slot.courtCentreId court_centre_id
      rota_slot.roomId room_id
    end
  end
end
