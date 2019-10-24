class CreateCourtApplicationResponseTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :court_application_response_types, id: :uuid do |t|
      t.integer :sequence
      t.string :description

      t.timestamps
    end
  end
end
