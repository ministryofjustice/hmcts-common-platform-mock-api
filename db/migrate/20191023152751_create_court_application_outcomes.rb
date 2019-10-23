class CreateCourtApplicationOutcomes < ActiveRecord::Migration[6.0]
  def change
    create_table :court_application_outcomes, id: :uuid do |t|
      t.uuid :originatingHearingId
      t.uuid :applicationId
      t.datetime :applicationOutcomeDate
      t.references :applicationOutcomeType, null: false, foreign_key: true

      t.timestamps
    end
  end
end
