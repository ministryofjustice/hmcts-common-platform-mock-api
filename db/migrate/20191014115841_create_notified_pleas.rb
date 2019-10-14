class CreateNotifiedPleas < ActiveRecord::Migration[6.0]
  def change
    create_table :notified_pleas, id: :uuid do |t|
      t.uuid :offenceId
      t.datetime :notifiedPleaDate
      t.string :notifiedPleaValue

      t.timestamps
    end
  end
end
