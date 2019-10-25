class CreateCourtApplicationPartyCounsels < ActiveRecord::Migration[6.0]
  def change
    create_table :court_application_party_counsels, id: :uuid do |t|
      t.uuid :applicationId
      t.string :title
      t.string :firstName
      t.string :middleName
      t.string :lastName
      t.string :status

      t.timestamps
    end

    add_reference :attendance_days, :court_application_party_counsel, type: :uuid, foreign_key: true
    add_reference :court_application_parties, :court_application_party_counsel, type: :uuid, foreign_key: true, index: { name: 'application_parties_on_court_application_party_counsel_id' }
  end
end
