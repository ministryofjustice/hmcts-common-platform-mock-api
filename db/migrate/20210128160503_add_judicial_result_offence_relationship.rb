class AddJudicialResultOffenceRelationship < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        execute "DELETE FROM judicial_results;"
      end
    end

    add_reference :judicial_results, :hearing, type: :uuid, null: false, foreign_key: true
  end
end
