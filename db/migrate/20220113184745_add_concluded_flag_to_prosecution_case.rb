class AddConcludedFlagToProsecutionCase < ActiveRecord::Migration[6.0]
  def change
    change_table :prosecution_cases do |t|
      t.boolean :concluded
    end
  end
end
