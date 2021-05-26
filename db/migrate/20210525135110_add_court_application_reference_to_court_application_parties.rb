class AddCourtApplicationReferenceToCourtApplicationParties < ActiveRecord::Migration[6.0]
  def change
    add_reference :court_application_parties, :court_application, type: :uuid, foreign_key: true
  end
end
