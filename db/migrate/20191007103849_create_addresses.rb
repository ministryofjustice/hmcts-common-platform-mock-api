class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses, id: :uuid do |t|
      t.string :address1, null: false
      t.string :address2
      t.string :address3
      t.string :address4
      t.string :address5
      t.string :postcode

      t.timestamps
    end
  end
end
