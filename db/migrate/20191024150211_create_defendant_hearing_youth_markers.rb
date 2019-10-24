class CreateDefendantHearingYouthMarkers < ActiveRecord::Migration[6.0]
  def change
    create_table :defendant_hearing_youth_markers, id: :uuid do |t|
      t.references :prosecution_case, type: :uuid, null: false, foreign_key: true
      t.references :defendant, type: :uuid, null: false, foreign_key: true
      t.uuid :hearing_id
      t.references :marker, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
