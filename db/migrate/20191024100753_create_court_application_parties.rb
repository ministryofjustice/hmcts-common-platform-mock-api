class CreateCourtApplicationParties < ActiveRecord::Migration[6.0]
  def change
    create_table :court_application_parties, id: :uuid do |t|
      t.string :synonym
      t.references :person, type: :uuid, null: false, foreign_key: true
      t.references :organisation, type: :uuid, null: false, foreign_key: true
      t.references :prosecuting_authority, type: :uuid, null: false, foreign_key: true
      t.references :defendant, type: :uuid, null: false, foreign_key: true
      t.references :representation_organisation, type: :uuid, null: false,
        foreign_key: { to_table: :organisations },
        index: { name: 'court_application_parties_on_rep_org_id' }

      t.timestamps
    end

    add_reference(:associated_people, :court_application_party, type: :uuid, foreign_key: true)
  end
end
