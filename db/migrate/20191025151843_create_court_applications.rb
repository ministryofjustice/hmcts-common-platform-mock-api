class CreateCourtApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :court_applications, id: :uuid do |t|
      t.references :application_type, type: :uuid, null: false, foreign_key: { to_table: :court_application_types }
      t.datetime :applicationReceivedDate
      t.string :applicationReference
      t.references :court_application_party, type: :uuid, null: false, foreign_key: true
      t.references :court_application_outcome, type: :uuid, foreign_key: true
      t.uuid :linkedCaseId
      t.string :linkedSplitProsecutorCaseReference
      t.uuid :parentApplicationId
      t.string :applicationParticulars
      t.references :court_application_payment, type: :uuid, foreign_key: true
      t.datetime :applicationDecisionSoughtByDate
      t.string :applicationStatus
      t.string :outOfTimeReasons
      t.string :breachedOrder
      t.string :breachedOrderDate
      t.references :court_centre, type: :uuid, foreign_key: true

      t.timestamps
    end

    add_reference :court_application_respondents, :court_application, type: :uuid, foreign_key: true
    add_reference :judicial_results, :court_application, type: :uuid, foreign_key: true
  end
end
