class CreateProsecutionCaseIdentifiers < ActiveRecord::Migration[6.0]
  def change
    create_table :prosecution_case_identifiers, id: :uuid do |t|
      t.string :caseURN
      t.string :prosecutionAuthorityReference
      t.uuid :prosecutionAuthorityId, null: false
      t.string :prosecutionAuthorityCode, null: false

      t.timestamps
    end
  end
end
