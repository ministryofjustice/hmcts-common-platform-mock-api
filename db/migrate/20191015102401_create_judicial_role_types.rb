class CreateJudicialRoleTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :judicial_role_types, id: :uuid do |t|
      t.uuid :judicialRoleTypeId
      t.string :judiciaryType

      t.timestamps
    end
  end
end
