class CreateAssociatedPeople < ActiveRecord::Migration[6.0]
  def change
    create_table :associated_people, id: :uuid do |t|
      t.references :person, type: :uuid, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
