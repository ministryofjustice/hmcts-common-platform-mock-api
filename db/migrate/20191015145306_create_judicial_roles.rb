class CreateJudicialRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :judicial_roles, id: :uuid do |t|
      t.uuid :judicialId
      t.string :title
      t.string :firstName
      t.string :middleName
      t.string :lastName
      t.references :judicial_role_type, type: :uuid, null: false, foreign_key: true
      t.boolean :isDeputy
      t.boolean :isBenchChairman

      t.timestamps
    end
  end
end
