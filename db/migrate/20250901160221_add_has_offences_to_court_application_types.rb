class AddHasOffencesToCourtApplicationTypes < ActiveRecord::Migration[8.0]
  def change
    add_column :court_application_types, :has_offences, :boolean, default: true
  end
end
