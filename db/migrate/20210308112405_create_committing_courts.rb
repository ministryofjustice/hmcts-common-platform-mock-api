class CreateCommittingCourts < ActiveRecord::Migration[6.0]
  def change
    create_table :committing_courts, id: :uuid do |t|
      t.uuid :court_centre_id
      t.string :court_house_type
      t.string :court_house_code
      t.string :court_house_name
      t.string :court_house_short_name

      t.timestamps
    end
  end
end
