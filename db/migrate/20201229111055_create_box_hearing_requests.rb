class CreateBoxHearingRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :box_hearing_requests, id: :uuid do |t|
      t.string :jurisdictionType
      t.uuid :court_centre_id
      t.datetime :applicationDueDate
      t.datetime :virtualAppointmentTime
      t.boolean :sendAppointmentLetter, null:false, default:false
      
      t.timestamps
    end
  end
end
