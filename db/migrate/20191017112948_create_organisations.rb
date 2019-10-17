class CreateOrganisations < ActiveRecord::Migration[6.0]
  def change
    create_table :organisations, id: :uuid do |t|
      t.string :name
      t.string :incorporationNumber
      t.string :registeredCharityNumber
      t.references :address, type: :uuid, foreign_key: true
      t.references :contact, type: :uuid, foreign_key: { to_table: :contact_numbers }

      t.timestamps
    end
  end
end
