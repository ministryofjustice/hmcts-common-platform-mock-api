class RemoveCourtApplicationResponse < ActiveRecord::Migration[6.0]
  def change
    drop_table :court_application_responses
  end
end
