class CreateAttendanceDays < ActiveRecord::Migration[6.0]
  def change
    create_table :attendance_days, id: :uuid do |t|
      t.datetime :day
      t.boolean :isInAttendance, null: false, default: false

      t.timestamps
    end
  end
end
