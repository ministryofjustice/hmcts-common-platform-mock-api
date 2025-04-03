class AddShortCodeToCourtApplications < ActiveRecord::Migration[8.0]
  def change
    add_column :court_applications, :short_code, :string
  end
end
