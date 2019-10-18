class AddDefendantRelationships < ActiveRecord::Migration[6.0]
  def change
    add_reference :offences, :defendant, type: :uuid, index: true, foreign_key: true
    add_reference :associated_people, :defendant, type: :uuid, index: true, foreign_key: true
    add_reference :associated_defence_organisations, :defendant, type: :uuid, index: true, foreign_key: true
    add_reference :defendant_aliases, :defendant, type: :uuid, index: true, foreign_key: true
    add_reference :judicial_results, :defendant, type: :uuid, index: true, foreign_key: true
    add_reference :markers, :defendant, type: :uuid, index: true, foreign_key: true
    add_reference :split_prosecutor_case_references, :defendant, type: :uuid, index: true, foreign_key: true
    add_reference :linked_defendants, :defendant, type: :uuid, index: true, foreign_key: true
  end
end
