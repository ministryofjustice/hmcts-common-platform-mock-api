class CreateMarkers < ActiveRecord::Migration[6.0]
  def change
    create_table :markers, id: :uuid do |t|
      t.uuid :markerTypeid
      t.string :sequenceNumber
      t.string :markerTypeCode
      t.string :markerTypeLabel
      t.string :markerTypeName
      t.string :splitProsecutorCaseReference

      t.timestamps
    end
  end
end
