class CreateVerdictTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :verdict_types, id: :uuid do |t|
      t.integer :sequence
      t.string :description
      t.string :category
      t.string :categoryType

      t.timestamps
    end
  end
end
