class CreateCourtApplicationRespondents < ActiveRecord::Migration[6.0]
  def change
    create_table :court_application_respondents, id: :uuid do |t|
      t.references :party_details, type: :uuid, null: false, foreign_key: { to_table: :court_application_parties }
      t.references :application_response, type: :uuid, foreign_key: { to_table: :court_application_responses }

      t.timestamps
    end
  end
end
