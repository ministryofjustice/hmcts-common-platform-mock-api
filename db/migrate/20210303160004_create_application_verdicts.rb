class CreateApplicationVerdicts < ActiveRecord::Migration[6.0]
  def change
    create_table :application_verdicts, id: :uuid do |t|
      t.uuid :originating_hearing_id
      t.uuid :application_id
      t.string :verdict_date
      t.references :verdict_type, type: :uuid, null: false, foreign_key: true
      t.references :jurors, type: :uuid, null: false, foreign_key: true
      t.references :lesser_or_alternative_offence, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
