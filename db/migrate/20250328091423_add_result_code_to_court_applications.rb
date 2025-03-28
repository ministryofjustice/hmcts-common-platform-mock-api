class AddResultCodeToCourtApplications < ActiveRecord::Migration[8.0]
  def change
    add_column :court_applications, :result_code, :string
  end
end
