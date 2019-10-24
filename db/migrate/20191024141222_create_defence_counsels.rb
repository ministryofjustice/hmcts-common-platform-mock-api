class CreateDefenceCounsels < ActiveRecord::Migration[6.0]
  def change
    create_table :defence_counsels, id: :uuid do |t|
      t.string :title
      t.string :firstName
      t.string :middleName
      t.string :lastName
      t.string :status

      t.timestamps
    end

    add_reference :defendants, :defence_counsel, type: :uuid, foreign_key: true
    add_reference :attendance_days, :defence_counsel, type: :uuid, foreign_key: true
  end
end
