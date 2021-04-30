class CreatePleaModels < ActiveRecord::Migration[6.0]
  def change
    create_table :plea_models, id: :uuid do |t|
      t.uuid :prosecution_case_id
      t.uuid :defendant_id
      t.uuid :offence_id
      t.references :indicated_plea, type: :uuid, null: false, foreign_key: true
      t.references :plea, type: :uuid, null: false, foreign_key: true
      t.references :allocation_decision, type: :uuid, null: false, foreign_key: true
      t.uuid :application_id

      t.timestamps
    end
  end
end
