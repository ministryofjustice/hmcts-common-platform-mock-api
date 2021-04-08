class UpdateCourtApplicationParties < ActiveRecord::Migration[6.0]
  def change
    change_table :court_application_parties do |t|
      t.references :master_defendant, type: :uuid, foreign_key: true
      t.boolean :appointment_notification_required
    end
  end
end
