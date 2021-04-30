class UpdateCourtApplicationType < ActiveRecord::Migration[6.0]
  def change
    change_table :court_application_types do |t|
      t.string :type
      t.string :category_code
      t.string :jurisdiction
      t.string :summons_template_type
      t.string :breach_type
      t.boolean :appeal_flag
      t.boolean :applicant_appellant_flag
      t.boolean :plea_applicable_flag
      t.boolean :commr_of_oath_flag
      t.boolean :court_of_appeal_flag
      t.boolean :court_extract_avl_flag
      t.boolean :prosecutor_third_party_flag
      t.boolean :spi_out_applicable_flag
      t.string :offence_active_order
      t.remove :applicantSynonym
      t.remove :applicationCategory
      t.remove :applicationCode
      t.remove :applicationJurisdictionType
      t.remove :applicationLegislation
      t.remove :applicationLegislationWelsh
      t.remove :applicationSummonsRecipientType
      t.remove :applicationSummonsTemplateType
      t.remove :applicationType
      t.remove :applicationTypeWelsh
      t.remove :isAppealApplication
      t.remove :isApplicationToRecordCourtOfAppealDecision
      t.remove :isBreachApplication
      t.remove :respondentSynonym
    end
  end
end
