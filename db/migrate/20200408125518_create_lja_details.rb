class CreateLjaDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :lja_details, id: :uuid do |t|
      t.string :ljaCode
      t.string :ljaName
      t.string :welshLjaName

      t.timestamps
    end

    add_reference :court_centres, :lja_details, type: :uuid, foreign_key: true
  end
end
