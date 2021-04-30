class CreateCompanyRepresentative < ActiveRecord::Migration[6.0]
  def change
    create_table :company_representatives, id: :uuid do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :position
      t.text :defendants, array: true, default: []
      t.text :attendance_days, array: true, default: []

      t.timestamps
    end
  end
end
