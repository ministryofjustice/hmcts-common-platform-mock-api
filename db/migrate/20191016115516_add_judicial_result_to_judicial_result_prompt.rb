class AddJudicialResultToJudicialResultPrompt < ActiveRecord::Migration[6.0]
  def change
    add_reference :judicial_result_prompts, :judicial_result, type: :uuid, index: true, foreign_key: true
  end
end
