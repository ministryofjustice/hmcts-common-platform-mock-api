class CreateIndicatedPleas < ActiveRecord::Migration[6.0]
  def change
    create_table :indicated_pleas, id: :uuid do |t|
      t.uuid :offenceId
      t.uuid :originatingHearingId
      t.datetime :indicatedPleaDate
      t.string :indicatedPleaValue
      t.string :source

      t.timestamps
    end
  end
end
