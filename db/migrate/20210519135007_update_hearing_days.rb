class UpdateHearingDays < ActiveRecord::Migration[6.0]
  def change
    change_table :hearing_days do |t|
      t.boolean :isCancelled
      t.uuid :courtRoomId
      t.remove :startTime
      t.remove :endTime
      t.remove :onTheDayCourtRoomId
    end
  end
end
