class AddNextHearingDefendantToNextHearingOffence < ActiveRecord::Migration[6.0]
  def change
    add_reference :next_hearing_offences, :next_hearing_defendant, type: :uuid, index: true, foreign_key: true
  end
end
