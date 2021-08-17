class UpdateHearing < ActiveRecord::Migration[6.0]
  def change
    change_table :hearings do |t|
      t.uuid :hearing_id
      t.datetime :sitting_day
    end
  end
end
