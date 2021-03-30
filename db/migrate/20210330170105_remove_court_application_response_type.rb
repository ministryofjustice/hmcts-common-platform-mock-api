class RemoveCourtApplicationResponseType < ActiveRecord::Migration[6.0]
  def change
    drop_table :court_application_response_types
  end
end
