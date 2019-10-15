class CreateNextHearings < ActiveRecord::Migration[6.0]
  def change
    create_table :next_hearings, id: :uuid do |t|
      t.references :hearing_type, type: :uuid, null: false, foreign_key: true
      t.string :jurisdictionType
      t.string :reportingRestrictionReason
      t.string :adjournmentReason
      t.string :hearingLanguage
      t.datetime :listedStartDateTime
      t.integer :estimatedMinutes
      t.references :court_centre, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
