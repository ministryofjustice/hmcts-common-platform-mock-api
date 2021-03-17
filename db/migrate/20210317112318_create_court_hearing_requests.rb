class CreateCourtHearingRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :court_hearing_requests, id: :uuid do |t|
      t.references :hearing_type, type: :uuid, null: false, foreign_key: true
      t.string :jurisdiction_type
      t.string :listed_start_date_time
      t.string :earliest_start_date_time
      t.string :end_date
      t.uuid :booking_reference
      t.json 'week_commencing_date'
      t.integer :estimate_minutes
      t.uuid :court_centre_id
      t.string :listing_directions

      t.timestamps
    end

    change_table :rota_slots do |t|
      t.belongs_to :court_hearing_request
    end

    change_table :judicial_roles do |t|
      t.belongs_to :court_hearing_request
    end
  end
end
