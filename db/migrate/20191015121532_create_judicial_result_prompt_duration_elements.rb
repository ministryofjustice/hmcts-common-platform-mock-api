class CreateJudicialResultPromptDurationElements < ActiveRecord::Migration[6.0]
  def change
    create_table :judicial_result_prompt_duration_elements, id: :uuid do |t|
      t.string :primaryDurationUnit
      t.integer :primaryDurationValue
      t.string :primaryLabel
      t.string :secondaryDurationUnit
      t.integer :secondaryDurationValue
      t.string :tertiaryDurationUnit
      t.string :tertiaryDurationValue
      t.datetime :durationStartDate
      t.datetime :durationEndDate

      t.timestamps
    end
  end
end
