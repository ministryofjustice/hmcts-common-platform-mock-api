class CreateCourtApplicationCases < ActiveRecord::Migration[6.0]
  def change
    create_table :court_application_cases, id: :uuid do |t|
      t.references :prosecution_case, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
