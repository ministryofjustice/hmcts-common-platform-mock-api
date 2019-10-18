class CreateMergedProsecutionCaseTargets < ActiveRecord::Migration[6.0]
  def change
    create_table :merged_prosecution_case_targets, id: :uuid do |t|
      t.uuid :prosecutionCaseId
      t.string :prosecutionCaseReference

      t.timestamps
    end
  end
end
