class CreateCustodyTimeLimits < ActiveRecord::Migration[6.0]
  def change
    create_table :custody_time_limits, id: :uuid do |t|
      t.datetime :timeLimit
      t.integer :daysSpent

      t.timestamps
    end
  end
end
