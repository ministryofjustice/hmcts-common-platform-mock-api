class AddPolymorphicRelationshipToDelegatedPowers < ActiveRecord::Migration[6.0]
  def change
    add_column :delegated_powers, :delegated_powerable_id, :uuid
    add_column :delegated_powers, :delegated_powerable_type, :string
    add_index :delegated_powers, [:delegated_powerable_type, :delegated_powerable_id], name: 'index_delegated_powers_on_delegated_powerable'
  end
end
