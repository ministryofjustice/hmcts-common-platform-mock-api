class ChangeDelegatedPowersToBelongsTo < ActiveRecord::Migration[6.0]
  def up
    remove_index :delegated_powers, [:delegated_powerable_type, :delegated_powerable_id]
    remove_column :delegated_powers, :delegated_powerable_type, :string
    remove_column :delegated_powers, :delegated_powerable_id, :uuid
    add_reference :pleas, :delegated_powers, type: :uuid, index: true
    add_foreign_key :pleas, :delegated_powers, column: :delegated_powers_id
  end

  def down
    remove_foreign_key :pleas, :delegated_powers
    remove_reference :pleas, :delegated_powers, index: true
    add_column :delegated_powers, :delegated_powerable_id, :uuid
    add_column :delegated_powers, :delegated_powerable_type, :string
    add_index :delegated_powers, [:delegated_powerable_type, :delegated_powerable_id], name: 'index_delegated_powers_on_delegated_powerable'
  end
end
