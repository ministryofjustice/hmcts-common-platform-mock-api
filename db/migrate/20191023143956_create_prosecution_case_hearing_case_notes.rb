class CreateProsecutionCaseHearingCaseNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :prosecution_case_hearing_case_notes, id: :uuid do |t|
      t.references :prosecution_case, type: :uuid, null: false, foreign_key: true, index: { name: 'prosecution_case_hearing_case_notes_on_prosecution_case_id' }
      t.references :hearing_case_note, type: :uuid, null: false, foreign_key: true, index: { name: 'prosecution_case_hearing_case_notes_on_hearing_case_note_id' }

      t.timestamps
    end
  end
end
