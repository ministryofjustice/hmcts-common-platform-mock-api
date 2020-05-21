class AddAlterableToHearingEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :hearing_events, :alterable, :boolean, default: false, null: false
  end
end
