class AddJudicialResultHearingRelationship < ActiveRecord::Migration[6.0]

  def up
    JudicialResult.destroy_all
    add_reference :judicial_results, :hearing, type: :uuid, null: false, foreign_key: true
  end
end
