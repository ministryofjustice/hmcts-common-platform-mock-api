class CreateHearingCaseNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :hearing_case_notes, id: :uuid do |t|
      t.uuid :originatingHearingId
      t.references :court_clerk, type: :uuid, null: false, foreign_key: { to_table: :delegated_powers }
      t.datetime :noteDateTime
      t.string :noteType
      t.string :note

      t.timestamps
    end
  end
end
