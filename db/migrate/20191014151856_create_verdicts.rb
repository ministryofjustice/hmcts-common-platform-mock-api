class CreateVerdicts < ActiveRecord::Migration[6.0]
  def change
    create_table :verdicts, id: :uuid do |t|
      t.uuid :originatingHearingId
      t.uuid :offenceId
      t.datetime :verdictDate
      t.references :verdict_type, type: :uuid, null: false, foreign_key: true
      t.references :jurors, type: :uuid, foreign_key: true
      t.references :lesser_or_alternative_offence, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
