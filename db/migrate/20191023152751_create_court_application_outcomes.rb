class CreateCourtApplicationOutcomes < ActiveRecord::Migration[6.0]
  def change
    create_table :court_application_outcomes, id: :uuid do |t|
      t.uuid :originatingHearingId
      t.uuid :applicationId
      t.datetime :applicationOutcomeDate
      t.references :application_outcome_type, type: :uuid, foreign_key: { to_table: :court_application_outcome_types }

      t.timestamps
    end
  end
end
