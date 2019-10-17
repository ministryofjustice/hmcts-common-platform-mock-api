class AddMergedProsecutionCaseToMergedProsecutionCaseTarget < ActiveRecord::Migration[6.0]
  def change
    add_reference :merged_prosecution_case_targets, :merged_prosecution_case, type: :uuid, index: { name: 'index_merged_prosecution_case_targets_on_case_id' }, foreign_key: true
  end
end
