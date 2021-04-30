class AddDateToCrackedIneffectiveTrial < ActiveRecord::Migration[6.0]
  def change
    add_column :cracked_ineffective_trials, :date, :string
  end
end
