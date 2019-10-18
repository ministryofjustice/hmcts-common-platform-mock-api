class CreateAssociatedDefenceOrganisations < ActiveRecord::Migration[6.0]
  def change
    create_table :associated_defence_organisations, id: :uuid do |t|
      t.references :organisation, type: :uuid, foreign_key: true, null: false
      t.string :sraNumber
      t.string :laaContractNumber
      t.string :barCouncilMembershipNumber
      t.datetime :associationStartDate
      t.datetime :associationEndDate
      t.string :fundingType
      t.boolean :isAssociatedByLAA

      t.timestamps
    end
  end
end
