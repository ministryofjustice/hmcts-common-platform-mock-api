class CreateDefendantCustodyLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :defendant_custody_locations, id: :uuid do |t|
      t.string :name
      t.belongs_to :address, null: false, type: :uuid, foreign_key: true
      t.string :emailAddress
      t.string :locationType

      t.timestamps
    end
  end
end
