class RemoveCourtApplicationOutcomeType < ActiveRecord::Migration[6.0]
  def change
    drop_table :court_application_outcome_types, force: :cascade, id: :uuid do |t|
      t.integer :sequence
      t.varchar :description
      t.timestamps
    end
  end
end
