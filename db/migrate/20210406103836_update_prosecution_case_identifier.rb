class UpdateProsecutionCaseIdentifier < ActiveRecord::Migration[6.0]
  def change
    change_table :prosecution_case_identifiers do |t|
      t.string :prosecution_authority_name
      t.string :prosecution_authority_oucode
      t.string :major_creditor_code
      t.references :address, type: :uuid, null: true, foreign_key: true
      t.references :contact_number, type: :uuid, null: true, foreign_key: true
    end
  end
end
