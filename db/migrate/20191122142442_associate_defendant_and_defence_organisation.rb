class AssociateDefendantAndDefenceOrganisation < ActiveRecord::Migration[6.0]
  def change
    add_column :defence_organisations, :associationStartDate, :datetime
    add_column :defence_organisations, :associationEndDate, :datetime
    add_column :defence_organisations, :fundingType, :string
    add_column :defence_organisations, :isAssociatedByLAA, :boolean, default: false, null: false
    add_reference :defence_organisations, :defendant, type: :uuid, index: true, foreign_key: true
    drop_table :associated_defence_organisations, id: :uuid do |t|
      t.references :organisation, type: :uuid, foreign_key: true, null: false
      t.references :defendant, type: :uuid, foreign_key: true
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
