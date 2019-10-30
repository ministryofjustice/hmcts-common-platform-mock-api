class RemoveDuplicateColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :defendants, :prosecutionCaseId, :uuid
    remove_column :hearing_case_notes, :originatingHearingId, :uuid
  end
end
