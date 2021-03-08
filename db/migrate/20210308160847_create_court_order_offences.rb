class CreateCourtOrderOffences < ActiveRecord::Migration[6.0]
  def change
    create_table :court_order_offences, id: :uuid do |t|
      t.references :offence, type: :uuid, null: false, foreign_key: true
      t.uuid :prosecution_case_id
      t.references :prosecution_case_identifier, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
