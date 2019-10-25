class CreateCourtApplicationResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :court_application_responses, id: :uuid do |t|
      t.uuid :originatingHearingId
      t.uuid :applicationId
      t.datetime :applicationResponseDate
      t.references :application_response_type, type: :uuid, null: false, foreign_key: { to_table: :court_application_response_types }, index: { name: 'application_responses_on_application_response_type_id' }

      t.timestamps
    end
  end
end
