class CreateLegalEntityDefendants < ActiveRecord::Migration[6.0]
  def change
    create_table :legal_entity_defendants, id: :uuid do |t|
      t.references :organisation, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
