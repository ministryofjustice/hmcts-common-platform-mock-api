class CreateProsecutingAuthorities < ActiveRecord::Migration[6.0]
  def change
    create_table :prosecuting_authorities, id: :uuid do |t|
      t.uuid :prosecutionAuthorityId
      t.string :prosecutionAuthorityCode
      t.string :name
      t.string :accountCode
      t.references :address, type: :uuid, foreign_key: true
      t.references :contact, type: :uuid, foreign_key: { to_table: :contact_numbers }

      t.timestamps
    end
  end
end
