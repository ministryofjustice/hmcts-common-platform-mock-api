class CreateCourtOrderSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :court_order_subjects, id: :uuid do |t|
      t.uuid :master_defendant_id
      t.string :organisation_name
      t.string :title
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :date_of_birth
      t.string :address_line_1
      t.string :pnc_id
      t.string :cro_number

      t.timestamps
    end
  end
end
