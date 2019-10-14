class AddPolymorphicAddressReferences < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :addressable_id, :uuid
    add_column :addresses, :addressable_type, :string
    add_index :addresses, [:addressable_type, :addressable_id]
    add_column :contact_numbers, :contactable_id, :uuid
    add_column :contact_numbers, :contactable_type, :string
    add_index :contact_numbers, [:contactable_type, :contactable_id]
  end
end
