class CreateHearingEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :hearing_events, id: :uuid do |t|
      t.references :hearing, null: false, type: :uuid, foreign_key: true
      t.uuid :hearingEventDefinitionId
      t.string :recordedLabel
      t.datetime :eventTime

      t.timestamps
    end
  end
end
