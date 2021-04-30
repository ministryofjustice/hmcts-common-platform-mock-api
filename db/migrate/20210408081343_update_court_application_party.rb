class UpdateCourtApplicationParty < ActiveRecord::Migration[6.0]
  def change
    change_table :court_application_parties do |t|
      t.boolean :summons_required
      t.boolean :notification_required
      t.remove :defendant_id
    end
  end
end
