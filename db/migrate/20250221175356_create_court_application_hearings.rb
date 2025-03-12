class CreateCourtApplicationHearings < ActiveRecord::Migration[7.1]
  def change
    create_table :court_application_hearings, id: :uuid do |t|
      t.references :hearing, type: :uuid, foreign_key: true
      t.references :court_application, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
