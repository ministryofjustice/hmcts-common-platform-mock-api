class CreateDefendantAliases < ActiveRecord::Migration[6.0]
  def change
    create_table :defendant_aliases, id: :uuid do |t|
      t.string :title
      t.string :firstName
      t.string :middleName
      t.string :lastName
      t.string :legalEntityName

      t.timestamps
    end
  end
end
