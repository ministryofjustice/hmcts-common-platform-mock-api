class CreateProsecutionCounsels < ActiveRecord::Migration[6.0]
  def change
    create_table :prosecution_counsels, id: :uuid do |t|
      t.string :title
      t.string :firstName
      t.string :middleName
      t.string :lastName
      t.string :status

      t.timestamps
    end

    add_reference :attendance_days, :prosecution_counsel, type: :uuid, foreign_key: true
    add_reference :prosecution_cases, :prosecution_counsel, type: :uuid, foreign_key: true
  end
end
