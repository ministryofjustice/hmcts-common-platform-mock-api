class CreateCourtApplicationPartyAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :court_application_party_attendances, id: :uuid do |t|
      t.references :court_application_party,
        type: :uuid,
        null: false,
        foreign_key: true,
        index: { name: 'attendances_on_court_application_party_id' }

      t.timestamps
    end

    add_reference :attendance_days, :court_application_party_attendance, type: :uuid, foreign_key: true
  end
end
