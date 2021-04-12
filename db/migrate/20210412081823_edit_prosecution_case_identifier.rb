class EditProsecutionCaseIdentifier < ActiveRecord::Migration[6.0]
  def change
    change_table :prosecution_case_identifiers do |t|
      t.remove :address_id
      t.references :address, type: :uuid, null: true, foreign_key: true
    end
  end
end
