class CreateProsecutionCases < ActiveRecord::Migration[6.0]
  def change
    create_table :prosecution_cases, id: :uuid do |t|
      t.references :prosecution_case_identifier, type: :uuid, null: false, foreign_key: true
      t.string :originatingOrganisation
      t.string :initiationCode
      t.string :caseStatus
      t.references :police_officer_in_case, type: :uuid, foreign_key: true
      t.string :statementOfFacts
      t.string :statementOfFactsWelsh
      t.boolean :breachProceedingsPending
      t.boolean :appealProceedingsPending
      t.references :merged_prosecution_case, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
