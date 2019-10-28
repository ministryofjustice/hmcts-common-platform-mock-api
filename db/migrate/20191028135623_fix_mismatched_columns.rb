class FixMismatchedColumns < ActiveRecord::Migration[6.0]
  def up
    reversible do |dir|
      dir.up do
        change_column :allocation_decisions, :court_indicated_sentence_id, :uuid, null: true
        change_column :judicial_result_prompt_duration_elements, :tertiaryDurationValue, :integer, using: '"tertiaryDurationValue"::integer'
      end
      dir.down do
        change_column :allocation_decisions, :court_indicated_sentence_id, :uuid, null: false
        change_column :judicial_result_prompt_duration_elements, :tertiaryDurationValue, :string
      end
    end
  end
end
