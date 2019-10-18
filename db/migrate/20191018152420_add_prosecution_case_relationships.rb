class AddProsecutionCaseRelationships < ActiveRecord::Migration[6.0]
  def change
    add_reference :defendants, :prosecution_case, type: :uuid, index: true, foreign_key: true
    add_reference :markers, :prosecution_case, type: :uuid, index: true, foreign_key: true
    add_reference :split_prosecutor_case_references, :prosecution_case, type: :uuid, index: true, foreign_key: true
    add_reference :linked_prosecution_cases, :prosecution_case, type: :uuid, index: true, foreign_key: true
  end
end
