class CreateCourtApplicationOffences < ActiveRecord::Migration[6.0]
  def change
    create_table :court_application_offences, id: :uuid do |t|
      t.string :offenceCode
      t.references :offence, type: :uuid, null: false, foreign_key: true
      t.references :court_application_case, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
