class CreateMasterDefendants < ActiveRecord::Migration[6.0]
  def change
    create_table :master_defendants, id: :uuid do |t|
      t.uuid :master_defendant_id
      t.references :person_defendant, type: :uuid, null: false, foreign_key: true
      t.references :legal_entity_defendant, type: :uuid, null: false, foreign_key: true
      t.boolean :is_youth
      t.string :pnc_id
      t.string :prosecution_authority_reference

      t.timestamps
    end

    change_table :associated_people do |t|
      t.belongs_to :master_defendant
    end

    change_table :defendant_cases do |t|
      t.belongs_to :master_defendant
    end
  end
end
