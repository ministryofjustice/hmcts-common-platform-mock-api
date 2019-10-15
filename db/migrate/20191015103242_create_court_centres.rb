class CreateCourtCentres < ActiveRecord::Migration[6.0]
  def change
    create_table :court_centres, id: :uuid do |t|
      t.string :name
      t.string :welshName
      t.uuid :roomId
      t.string :roomName
      t.string :welshRoomName
      t.references :address, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
