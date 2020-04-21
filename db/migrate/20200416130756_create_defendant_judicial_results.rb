class CreateDefendantJudicialResults < ActiveRecord::Migration[6.0]
  def change
    create_table :defendant_judicial_results, id: :uuid do |t|
      t.uuid :masterDefendantId
      t.references :judicial_result, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
