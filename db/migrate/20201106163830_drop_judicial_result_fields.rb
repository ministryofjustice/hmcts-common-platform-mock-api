class DropJudicialResultFields < ActiveRecord::Migration[6.0]
  def change
    remove_column :judicial_results, :isLifeDuration, :boolean, null: false, default: false
    remove_column :judicial_results, :isPublishedAsAPrompt, :boolean, null: false, default: false
    remove_column :judicial_results, :isExcludedFromResults, :boolean, null: false, default: false
    remove_column :judicial_results, :isAlwaysPublished, :boolean, null: false, default: false
    remove_column :judicial_results, :isUrgent, :boolean, null: false, default: false
    remove_column :judicial_results, :isD20, :boolean, null: false, default: false
  end
end
