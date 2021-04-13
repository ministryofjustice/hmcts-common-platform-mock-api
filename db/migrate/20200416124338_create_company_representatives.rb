class CreateCompanyRepresentatives < ActiveRecord::Migration[6.0]
  def change
    create_table :company_representatives, id: :uuid do |t|
      t.string :title
      t.string :firstName
      t.string :lastName
      t.string :position

      t.timestamps
    end
  end
end
