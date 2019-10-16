class AddJudicialResultPromptToUserGroup < ActiveRecord::Migration[6.0]
  def change
    add_reference :user_groups, :judicial_result_prompt, type: :uuid, index: true, foreign_key: true
  end
end
