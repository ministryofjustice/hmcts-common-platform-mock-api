class CreateHearings < ActiveRecord::Migration[6.0]
  def change
    create_table :hearings, id: :uuid do |t|
      t.string :jurisdictionType
      t.string :reportingRestrictionReason
      t.references :court_centre, type: :uuid, null: false, foreign_key: true
      t.string :hearingLanguage
      t.boolean :hasSharedResults
      t.references :hearing_type, type: :uuid, null: false, foreign_key: true
      t.references :cracked_ineffective_trial, type: :uuid, foreign_key: true
      t.boolean :isEffectiveTrial
      t.boolean :isBoxHearing

      t.timestamps
    end

    add_reference :prosecution_cases, :hearing, type: :uuid, foreign_key: true
    add_reference :court_applications, :hearing, type: :uuid, foreign_key: true
    add_reference :referral_reasons, :hearing, type: :uuid, foreign_key: true
    add_reference :hearing_case_notes, :hearing, type: :uuid, foreign_key: true
    add_reference :hearing_days, :hearing, type: :uuid, foreign_key: true
    add_reference :judicial_roles, :hearing, type: :uuid, foreign_key: true
    add_reference :applicant_counsels, :hearing, type: :uuid, foreign_key: true
    add_reference :respondent_counsels, :hearing, type: :uuid, foreign_key: true
    add_reference :prosecution_counsels, :hearing, type: :uuid, foreign_key: true
    add_reference :defence_counsels, :hearing, type: :uuid, foreign_key: true
    add_reference :court_application_party_counsels, :hearing, type: :uuid, foreign_key: true
    add_reference :defendant_attendances, :hearing, type: :uuid, foreign_key: true
    add_reference :court_application_party_attendances, :hearing, type: :uuid, foreign_key: true
    add_index :defendant_hearing_youth_markers, :hearing_id
    add_foreign_key :defendant_hearing_youth_markers, :hearings
  end
end
