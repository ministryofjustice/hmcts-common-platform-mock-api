class CreateApplicationPleas < ActiveRecord::Migration[6.0]
  def change
    create_table :application_pleas, id: :uuid do |t|
      t.uuid :originating_hearing_id
      t.references :delegated_powers, type: :uuid, null: false, foreign_key: true
      t.uuid :application_id
      t.string :plea_date
      t.string :plea_value
      t.references :lesser_or_alternative_offence, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end

  end
end
