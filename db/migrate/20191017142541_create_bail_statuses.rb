class CreateBailStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :bail_statuses, id: :uuid do |t|
      t.string :code
      t.string :description
      t.references :custody_time_limit, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
