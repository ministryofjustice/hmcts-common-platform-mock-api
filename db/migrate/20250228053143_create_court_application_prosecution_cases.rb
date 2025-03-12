class CreateCourtApplicationProsecutionCases < ActiveRecord::Migration[7.1]
  def change
    create_table :court_application_prosecution_cases, id: :uuid do |t|
      t.references :prosecution_case, type: :uuid, null: false, foreign_key: true
      t.references :court_application, type: :uuid, null: false, foreign_key: true
      t.timestamps
    end
  end
end
