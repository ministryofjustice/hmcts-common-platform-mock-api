class CreateCourtApplicationOutcomeTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :court_application_outcome_types, id: :uuid do |t|
      t.integer :sequence
      t.string :description

      t.timestamps
    end
  end
end
