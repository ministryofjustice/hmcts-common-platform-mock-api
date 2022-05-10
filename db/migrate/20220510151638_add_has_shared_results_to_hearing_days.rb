class AddHasSharedResultsToHearingDays < ActiveRecord::Migration[6.0]
  def change
    add_column :hearing_days, :hasSharedResults, :boolean
  end
end
