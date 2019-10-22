class CreateCourtApplicationTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :court_application_types, id: :uuid do |t|
      t.string :applicationCode
      t.string :applicationType
      t.string :applicationTypeWelsh
      t.string :applicationLegislation
      t.string :applicationLegislationWelsh
      t.string :applicationCategory
      t.boolean :isAppealApplication
      t.boolean :isBreachApplication
      t.boolean :isApplicationToRecordCourtOfAppealDecision
      t.string :linkType
      t.string :applicantSynonym
      t.string :respondentSynonym
      t.string :applicationJurisdictionType
      t.string :applicationSummonsRecipientType
      t.string :applicationSummonsTemplateType

      t.timestamps
    end
  end
end
