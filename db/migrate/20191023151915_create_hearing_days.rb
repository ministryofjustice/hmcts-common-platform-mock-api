class CreateHearingDays < ActiveRecord::Migration[6.0]
  def change
    create_table :hearing_days, id: :uuid do |t|
      t.datetime :sittingDay
      t.integer :listingSequence
      t.integer :listedDurationMinutes

      t.timestamps
    end
  end
end
