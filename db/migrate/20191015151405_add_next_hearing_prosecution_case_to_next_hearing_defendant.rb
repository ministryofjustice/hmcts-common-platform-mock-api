class AddNextHearingProsecutionCaseToNextHearingDefendant < ActiveRecord::Migration[6.0]
  def change
    add_reference :next_hearing_defendants, :next_hearing_prosecution_case, type: :uuid, index: { name: 'index_next_hearing_defendants_on_prosecution_case_id' }, foreign_key: true
  end
end
