class UpdateCourtApplications < ActiveRecord::Migration[6.0]
  def change
    change_table :court_applications do |t|
      t.remove :linkedCaseId
      t.remove :linkedSplitProsecutorCaseReference
      t.remove :breachedOrderDate
    end
  end
end
