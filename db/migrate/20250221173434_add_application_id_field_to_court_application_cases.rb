class AddApplicationIdFieldToCourtApplicationCases < ActiveRecord::Migration[7.1]
  def change
    add_reference :court_application_cases, :court_application, type: :uuid, foreign_key: true
  end
end
