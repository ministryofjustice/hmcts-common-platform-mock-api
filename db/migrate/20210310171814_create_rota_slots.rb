class CreateRotaSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :rota_slots, id: :uuid do |t|
      t.string :start_time
      t.integer :duration
      t.string :court_schedule_id
      t.string :session
      t.string :oucode
      t.integer :court_room_id
      t.string :court_centre_id
      t.string :room_id

      t.timestamps
    end
  end
end
