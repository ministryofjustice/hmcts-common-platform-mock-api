class CreateLjaDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :lja_details, id: :uuid do |t|
      t.string :lja_code
      t.string :lja_name
      t.string :welsh_lja_name

      t.timestamps
    end
  end
end
