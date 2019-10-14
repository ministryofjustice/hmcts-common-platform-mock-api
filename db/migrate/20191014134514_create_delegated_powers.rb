class CreateDelegatedPowers < ActiveRecord::Migration[6.0]
  def change
    create_table :delegated_powers, id: :uuid do |t|
      t.uuid :userId
      t.string :firstName
      t.string :lastName

      t.timestamps
    end
  end
end
