class CreateRespondentCounsels < ActiveRecord::Migration[6.0]
  def change
    create_table :respondent_counsels, id: :uuid do |t|
      t.string :title
      t.string :firstName
      t.string :middleName
      t.string :lastName
      t.string :status

      t.timestamps
    end

    add_reference :court_application_respondents, :respondent_counsel, type: :uuid, foreign_key: true
    add_reference :attendance_days, :respondent_counsel, type: :uuid, foreign_key: true
  end
end
