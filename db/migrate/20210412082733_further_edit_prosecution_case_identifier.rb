class FurtherEditProsecutionCaseIdentifier < ActiveRecord::Migration[6.0]
  def change
    change_table :prosecution_case_identifiers do |t|
      t.remove :contact_number_id
      t.references :contact_number, type: :uuid, null: true, foreign_key: true
    end
  end
end
