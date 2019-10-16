class CreateJudicialResultPrompts < ActiveRecord::Migration[6.0]
  def change
    create_table :judicial_result_prompts, id: :uuid do |t|
      t.string :label
      t.boolean :isAvailableForCourtExtract, null: false
      t.string :welshLabel
      t.string :value
      t.string :qualifier
      t.integer :durationSequence
      t.integer :promptSequence
      t.string :promptReference
      t.integer :totalPenaltyPoints
      t.boolean :isFinancialImposition

      t.timestamps
    end
  end
end
