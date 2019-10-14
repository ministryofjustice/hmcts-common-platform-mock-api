class CreatePleas < ActiveRecord::Migration[6.0]
  def change
    create_table :pleas, id: :uuid do |t|
      t.uuid :originatingHearingId
      t.uuid :offenceId
      t.datetime :pleaDate
      t.string :pleaValue

      t.timestamps
    end
  end
end
