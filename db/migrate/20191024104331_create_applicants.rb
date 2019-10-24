class CreateApplicants < ActiveRecord::Migration[6.0]
  def change
    create_table :applicants, id: :uuid do |t|
      t.references :applicant_counsel, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
