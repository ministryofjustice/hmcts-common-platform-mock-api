class AddDefendantIdFieldsToCourtApplications < ActiveRecord::Migration[7.1]
  def change
    add_reference :court_applications, :defendant, type: :uuid
  end
end
