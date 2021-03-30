class RemoveCourtApplicationRespondent < ActiveRecord::Migration[6.0]
  def change
    drop_table :court_application_respondents, id: :uuid do |t|
      t.uuid :party_details_id
      t.uuid :application_response_id
      t.uuid :respondent_counsel_id
      t.uuid :court_application_id
      t.timestamps
    end
  end
end
