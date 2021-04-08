class UpdateCourtApplication < ActiveRecord::Migration[6.0]
  def change
    change_table :court_applications do |t|
      t.references :court_application_type, type: :uuid, foreign_key: true
      t.remove :application_type_id
    end
  end
end
