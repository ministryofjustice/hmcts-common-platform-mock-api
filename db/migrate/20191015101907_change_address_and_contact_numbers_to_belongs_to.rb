class ChangeAddressAndContactNumbersToBelongsTo < ActiveRecord::Migration[6.0]
  def change
    remove_index :addresses, [:addressable_type, :addressable_id]
    remove_column :addresses, :addressable_id, :uuid
    remove_column :addresses, :addressable_type, :string
    remove_index :contact_numbers, [:contactable_type, :contactable_id]
    remove_column :contact_numbers, :contactable_id, :uuid
    remove_column :contact_numbers, :contactable_type, :string
    add_reference :people, :address, type: :uuid, index: true, foreign_key: true
    add_reference :people, :contact_number, type: :uuid, index: true, foreign_key: true
  end
end
