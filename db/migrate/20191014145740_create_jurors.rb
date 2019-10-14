class CreateJurors < ActiveRecord::Migration[6.0]
  def change
    create_table :jurors, id: :uuid do |t|
      t.integer :numberOfJurors
      t.integer :numberOfSplitJurors
      t.boolean :unanimous

      t.timestamps
    end
  end
end
