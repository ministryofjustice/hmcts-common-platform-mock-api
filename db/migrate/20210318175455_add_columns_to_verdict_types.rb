class AddColumnsToVerdictTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :verdict_types, :cjs_verdict_code, :string
    add_column :verdict_types, :verdict_code, :string
  end
end
