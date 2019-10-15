class CreateNextHearingDefendants < ActiveRecord::Migration[6.0]
  def change
    create_table :next_hearing_defendants, id: :uuid do |t|

      t.timestamps
    end
  end
end
