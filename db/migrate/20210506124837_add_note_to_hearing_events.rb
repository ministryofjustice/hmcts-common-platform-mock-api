class AddNoteToHearingEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :hearing_events, :note, :string
  end
end
