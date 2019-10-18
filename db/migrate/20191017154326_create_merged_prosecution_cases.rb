class CreateMergedProsecutionCases < ActiveRecord::Migration[6.0]
  def change
    create_table :merged_prosecution_cases, id: :uuid do |t|
      t.string :prosecutionCaseReference

      t.timestamps
    end
  end
end
