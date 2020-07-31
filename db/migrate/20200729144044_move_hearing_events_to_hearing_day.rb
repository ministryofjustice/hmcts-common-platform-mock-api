class MoveHearingEventsToHearingDay < ActiveRecord::Migration[6.0]
  def up
    add_reference :hearing_events, :hearing_day, type: :uuid, index: true, foreign_key: true

    execute <<~SQL
      UPDATE hearing_events
      SET hearing_day_id = hearing_days.id
      FROM hearing_days
      WHERE hearing_days.hearing_id = hearing_events.hearing_id
    SQL

    change_column_null :hearing_events, :hearing_day_id, false

    remove_reference :hearing_events, :hearing, type: :uuid, index: true, foreign_key: true
  end

  def down
    add_reference :hearing_events, :hearing, type: :uuid, index: true, foreign_key: true

    execute <<~SQL
      UPDATE hearing_events
      SET hearing_id = hearing_days.hearing_id
      FROM hearing_days
      WHERE hearing_days.id = hearing_events.hearing_day_id
    SQL

    change_column_null :hearing_events, :hearing_id, false

    remove_reference :hearing_events, :hearing_day, type: :uuid, index: true, foreign_key: true
  end
end
