class CreateInterpreterIntermediaries < ActiveRecord::Migration[6.0]
  def change
    create_table :interpreter_intermediaries, id: :uuid do |t|
      t.string :role
      t.string :firstName
      t.string :lastName
      t.references :attendant, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
