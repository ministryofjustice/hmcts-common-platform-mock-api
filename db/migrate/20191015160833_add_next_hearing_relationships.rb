class AddNextHearingRelationships < ActiveRecord::Migration[6.0]
  def change
    add_reference :judicial_roles, :next_hearing, type: :uuid, index: true, foreign_key: true
    add_reference :next_hearing_prosecution_cases, :next_hearing, type: :uuid, index: true, foreign_key: true
    add_reference :next_hearing_court_applications, :next_hearing, type: :uuid, index: true, foreign_key: true
  end
end
