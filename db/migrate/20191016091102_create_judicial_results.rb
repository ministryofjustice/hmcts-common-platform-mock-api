class CreateJudicialResults < ActiveRecord::Migration[6.0]
  def change
    create_table :judicial_results, id: :uuid do |t|
      t.uuid :judicialResultId
      t.uuid :orderedHearingId
      t.string :label
      t.string :welshLabel
      t.boolean :isAdjournmentResult, null: false
      t.boolean :isFinancialResult, null: false
      t.boolean :isConvictedResult, null: false
      t.boolean :isAvailableForCourtExtract, null: false
      t.boolean :isDeleted
      t.uuid :amendmentReasonId
      t.string :amendmentReason
      t.datetime :amendmentDate
      t.string :qualifier
      t.string :resultText
      t.string :cjsCode
      t.string :postHearingCustodyStatus
      t.integer :rank
      t.datetime :orderedDate
      t.string :lastSharedDateTime
      t.boolean :terminatesOffenceProceedings, null: false
      t.boolean :isLifeDuration, null: false
      t.boolean :isPublishedAsAPrompt, null: false
      t.boolean :isExcludedFromResults, null: false
      t.boolean :isAlwaysPublished, null: false
      t.boolean :isUrgent, null: false
      t.boolean :isD20, null: false
      t.references :court_clerk, type: :uuid, foreign_key: { to_table: :delegated_powers }
      t.references :delegated_powers, type: :uuid, foreign_key: true
      t.references :four_eyes_approval, type: :uuid, foreign_key: { to_table: :delegated_powers }
      t.datetime :approvedDate
      t.string :category
      t.references :next_hearing, type: :uuid, foreign_key: true
      t.references :duration_element, type: :uuid, foreign_key: { to_table: :judicial_result_prompt_duration_elements }

      t.timestamps
    end
  end
end
