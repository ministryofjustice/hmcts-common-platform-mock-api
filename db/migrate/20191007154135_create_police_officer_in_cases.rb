class CreatePoliceOfficerInCases < ActiveRecord::Migration[6.0]
  def change
    create_table :police_officer_in_cases, id: :uuid do |t|
      t.references :person, type: :uuid, null: false, foreign_key: true
      t.string :policeOfficerRank
      t.string :policeWorkerReferenceNumber
      t.string :policeWorkerLocationCode

      t.timestamps
    end
  end
end
