class CreateFutureSummonsHearings < ActiveRecord::Migration[6.0]
  def change
    create_table :future_summons_hearings, id: :uuid do |t|
      t.string :jurisdiction_type
      t.string :earliest_start_date_time
      t.json :week_commencing_date
      t.integer :estimated_minutes
      t.uuid :court_centre_id

      t.timestamps
    end

    change_table :judicial_roles do |t|
      t.belongs_to :future_summons_hearing
    end
  end
end
