class CreateDefenceOrganisations < ActiveRecord::Migration[6.0]
  def change
    create_table :defence_organisations, id: :uuid do |t|
      t.references :organisation, type: :uuid, null: false, foreign_key: true
      t.string :laaContractNumber
      t.string :sraNumber
      t.string :barCouncilMembershipNumber

      t.timestamps
    end
  end
end
