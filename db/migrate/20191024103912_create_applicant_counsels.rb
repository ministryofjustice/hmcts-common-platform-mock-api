class CreateApplicantCounsels < ActiveRecord::Migration[6.0]
  def change
    create_table :applicant_counsels, id: :uuid do |t|
      t.string :title
      t.string :firstName
      t.string :middleName
      t.string :lastName
      t.string :status

      t.timestamps
    end

    add_reference :attendance_days, :applicant_counsel, type: :uuid, foreign_key: true
  end
end
