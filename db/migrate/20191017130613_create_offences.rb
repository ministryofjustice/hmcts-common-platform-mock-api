class CreateOffences < ActiveRecord::Migration[6.0]
  def change
    create_table :offences, id: :uuid do |t|
      t.uuid :offenceDefinitionId
      t.string :offenceCode
      t.string :offenceTitle
      t.string :offenceTitleWelsh
      t.string :offenceLegislation
      t.string :offenceLegislationWelsh
      t.string :modeOfTrial
      t.string :wording
      t.string :wordingWelsh
      t.datetime :startDate
      t.datetime :endDate
      t.datetime :arrestDate
      t.datetime :chargeDate
      t.datetime :dateOfInformation
      t.integer :orderIndex
      t.integer :count
      t.datetime :convictionDate
      t.references :notified_plea, type: :uuid, foreign_key: true
      t.references :indicated_plea, type: :uuid, foreign_key: true
      t.references :allocation_decision, type: :uuid, foreign_key: true
      t.references :plea, type: :uuid, foreign_key: true
      t.references :verdict, type: :uuid, foreign_key: true
      t.references :offence_facts, type: :uuid, foreign_key: true
      t.datetime :aquittalDate
      t.boolean :isDisposed
      t.boolean :isDiscontinued
      t.boolean :isIntroduceAfterInitialProceedings
      t.references :custody_time_limit, type: :uuid, foreign_key: true
      t.string :splitProsecutorCaseReference
      t.string :mergedProsecutionCaseReference

      t.timestamps
    end
  end
end
