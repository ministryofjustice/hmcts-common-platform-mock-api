class RemoveColumnFromMasterDefendants < ActiveRecord::Migration[6.0]
  def change
    remove_column :master_defendants, :legal_entity_defendant_id
  end
end
