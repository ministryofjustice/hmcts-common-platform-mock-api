class CreateDefendants < ActiveRecord::Migration[6.0]
  def change
    create_table :defendants, id: :uuid do |t|
      t.uuid :prosecutionCaseId
      t.integer :numberOfPreviousConvictionsCited
      t.string :prosecutionAuthorityReference
      t.string :witnessStatement
      t.string :witnessStatementWelsh
      t.string :mitigation
      t.string :mitigationWelsh
      t.string :defendable_type, null: false
      t.uuid :defendable_id, null: false
      t.string :croNumber
      t.string :pncId
      t.string :mergedProsecutionCaseReference

      t.timestamps
    end
    add_index :defendants, [:defendable_type, :defendable_id]
  end
end
