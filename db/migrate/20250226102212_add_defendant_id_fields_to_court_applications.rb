class AddDefendantIdFieldsToCourtApplications < ActiveRecord::Migration[7.1]
  def up
    add_reference :court_applications, :defendant, type: :uuid
  end

  def down
    remove_reference :court_applications, :defendant
  end
end
