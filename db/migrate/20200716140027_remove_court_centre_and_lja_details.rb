class RemoveCourtCentreAndLjaDetails < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :court_applications, :court_centres
    remove_foreign_key :hearing_days, :court_centres
    remove_foreign_key :hearings, :court_centres
    remove_foreign_key :next_hearings, :court_centres

    drop_table :court_centres, id: :uuid do |t|
      t.string :name
      t.string :welshName
      t.uuid :roomId
      t.string :roomName
      t.string :welshRoomName
      t.references :address, type: :uuid, foreign_key: true
      t.timestamps
      t.references :lja_details, type: :uuid, foreign_key: true
      t.string :ouCode
      t.string :courtHearingLocation
    end


    reversible do |dir|
      dir.up do
        # Map all existing court_centres to a known court centre id
        execute "UPDATE court_applications SET court_centre_id = 'bc4864ca-4b22-3449-9716-a8db1db89905'"
        execute "UPDATE hearing_days SET court_centre_id = 'bc4864ca-4b22-3449-9716-a8db1db89905'"
        execute "UPDATE hearings SET court_centre_id = 'bc4864ca-4b22-3449-9716-a8db1db89905'"
        execute "UPDATE next_hearings SET court_centre_id = 'bc4864ca-4b22-3449-9716-a8db1db89905'"

      end
    end
  end
end
