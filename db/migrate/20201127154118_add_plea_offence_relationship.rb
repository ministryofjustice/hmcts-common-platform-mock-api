class AddPleaOffenceRelationship < ActiveRecord::Migration[6.0]

  def change
    remove_reference :offences, :plea, type: :uuid, foreign_key: true
    remove_reference :offences, :indicated_plea, type: :uuid, foreign_key: true
    remove_reference :offences, :notified_plea, type: :uuid, foreign_key: true
    remove_reference :offences, :allocation_decision, type: :uuid, foreign_key: true
    remove_reference :offences, :verdict, type: :uuid, foreign_key: true

    reversible do |dir|
      dir.up do
        execute "DELETE FROM pleas;"
        execute "DELETE FROM indicated_pleas;"
        execute "DELETE FROM notified_pleas;"
        execute "DELETE FROM allocation_decisions;"
        execute "DELETE FROM verdicts;"
      end
    end

    remove_column :pleas, :offenceId, :uuid
    remove_column :pleas, :originatingHearingId, :uuid

    add_reference :pleas, :offence, type: :uuid, null: false, foreign_key: true
    add_reference :pleas, :hearing, type: :uuid, null: false, foreign_key: true


    remove_column :notified_pleas, :offenceId, :uuid

    add_reference :notified_pleas, :offence, type: :uuid, null: false, foreign_key: true

    remove_column :indicated_pleas, :offenceId, :uuid
    remove_column :indicated_pleas, :originatingHearingId, :uuid

    add_reference :indicated_pleas, :offence, type: :uuid, null: false, foreign_key: true
    add_reference :indicated_pleas, :hearing, type: :uuid, null: false, foreign_key: true


    remove_column :allocation_decisions, :offenceId, :uuid
    remove_column :allocation_decisions, :originatingHearingId, :uuid

    add_reference :allocation_decisions, :offence, type: :uuid, null: false, foreign_key: true
    add_reference :allocation_decisions, :hearing, type: :uuid, null: false, foreign_key: true

    remove_column :verdicts, :offenceId, :uuid
    remove_column :verdicts, :originatingHearingId, :uuid

    add_reference :verdicts, :offence, type: :uuid, null: false, foreign_key: true
    add_reference :verdicts, :hearing, type: :uuid, null: false, foreign_key: true
  end
end
