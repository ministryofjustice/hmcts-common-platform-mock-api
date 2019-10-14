class CreateLesserOrAlternativeOffences < ActiveRecord::Migration[6.0]
  def change
    create_table :lesser_or_alternative_offences, id: :uuid do |t|
      t.uuid :offenceDefinitionId
      t.string :offenceCode
      t.string :offenceTitle
      t.string :offenceTitleWelsh
      t.string :offenceLegislation
      t.string :offenceLegislationWelsh

      t.timestamps
    end
  end
end
