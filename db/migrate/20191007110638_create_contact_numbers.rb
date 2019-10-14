class CreateContactNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :contact_numbers, id: :uuid do |t|
      t.string :home
      t.string :work
      t.string :mobile
      t.string :primaryEmail
      t.string :secondaryEmail
      t.string :fax

      t.timestamps
    end
  end
end
