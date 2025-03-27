class AddApplicationIdFieldToCourtApplicationCases < ActiveRecord::Migration[7.1]
  def up
    add_reference :court_application_cases, :court_application, type: :uuid, foreign_key: true
  end

  def down
    remove_reference :court_application_cases, :court_application, foreign_key: true
  end
end
