class CreateCourtApplicationCases < ActiveRecord::Migration[6.0]
  def change
    create_table :court_application_cases, id: :uuid do |t|
      t.uuid :prosecution_case_id
      t.boolean :is_sjp
      t.references :prosecution_case_identifier, type: :uuid, null: false, foreign_key: true
      t.string :case_status

      t.timestamps
    end

    change_table :offences do |t|
      t.belongs_to :court_application_case
    end
  end
end
