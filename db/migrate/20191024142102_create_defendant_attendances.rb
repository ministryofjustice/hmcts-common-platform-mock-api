class CreateDefendantAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :defendant_attendances, id: :uuid do |t|
      t.references :defendant, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end

    add_reference :attendance_days, :defendant_attendance, type: :uuid, foreign_key: true
  end
end
