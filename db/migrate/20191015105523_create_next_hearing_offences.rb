class CreateNextHearingOffences < ActiveRecord::Migration[6.0]
  def change
    create_table :next_hearing_offences, id: :uuid do |t|

      t.timestamps
    end
  end
end
