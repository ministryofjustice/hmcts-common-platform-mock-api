class UpdateJudicialResultPrompt < ActiveRecord::Migration[6.0]
  def change
    add_column :judicial_result_prompts, :welsh_value, :string
  end
end
