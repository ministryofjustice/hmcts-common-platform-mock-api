class ChangeCourtApplicationPartyDefaults < ActiveRecord::Migration[6.0]
  def change
    change_column_null :court_application_parties, :person_id, true
    change_column_null :court_application_parties, :organisation_id, true
    change_column_null :court_application_parties, :prosecuting_authority_id, true
    change_column_null :court_application_parties, :defendant_id, true
    change_column_null :court_application_parties, :representation_organisation_id, true
  end
end
