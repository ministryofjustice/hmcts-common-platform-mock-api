class AddOnePointFiveFields < ActiveRecord::Migration[6.0]
  def change
    add_column :attendance_days, :byVideoLinkFromCustodyLocation, :boolean, default: false, null: false
    add_column :defendants, :masterDefendantId, :uuid, index: true
    add_column :defendants, :courtProceedingsInitiated, :datetime
    add_column :defendants, :defendantDetailsUpdated, :boolean, default: false, null: false
    add_column :court_centres, :ouCode, :string
    add_column :court_centres, :courtHearingLocation, :string
    add_column :hearing_days, :startTime, :time
    add_column :hearing_days, :endTime, :time
    add_column :hearing_days, :onTheDayCourtRoomId, :uuid
    add_column :judicial_results, :judicialResultTypeId, :uuid
    add_column :judicial_result_prompts, :judicialResultPromptTypeId, :uuid
    add_column :laa_references, :offenceLevelStatus, :string
    add_column :prosecution_cases, :removalReason, :string
    add_column :offences, :dvlaCode, :string
    add_column :offences, :laidDate, :datetime
    add_column :offences, :proceedingsConcluded, :boolean, default: false, null: false
    add_column :offences, :pendingCBPW, :boolean, default: false, null: false
    add_column :offences, :civilOffence, :boolean, default: false, null: false

    add_reference :attendance_days, :company_representatives, type: :uuid, foreign_key: true
    add_reference :attendance_days, :interpreter_intermediary, type: :uuid, foreign_key: true
    add_reference :company_representatives, :hearing, type: :uuid, foreign_key: true
    add_reference :defendant_judicial_results, :hearing, type: :uuid, foreign_key: true
    add_reference :defendants, :company_representatives, type: :uuid, foreign_key: true
    add_reference :hearing_days, :court_centre, type: :uuid, foreign_key: true
    add_reference :interpreter_intermediaries, :hearing, type: :uuid, foreign_key: true
    add_reference :judicial_roles, :hearing_day, type: :uuid, foreign_key: true
    add_reference :person_defendants, :defendant_custody_location, type: :uuid, foreign_key: true
  end
end
