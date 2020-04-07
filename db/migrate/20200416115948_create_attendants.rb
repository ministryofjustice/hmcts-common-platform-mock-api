class CreateAttendants < ActiveRecord::Migration[6.0]
  def change
    create_table :attendants, id: :uuid do |t|
      t.string :attendantType
      t.string :name
      t.references :defendant, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
