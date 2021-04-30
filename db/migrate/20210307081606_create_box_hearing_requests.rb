class CreateBoxHearingRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :box_hearing_requests, id: :uuid do |t|
      t.uuid :court_centre_id
      t.string :jurisdiction_type
      t.string :application_due_date
      t.string :virtual_appointment_time
      t.boolean :send_appointment_letter

      t.timestamps
    end
  end
end
