class AddApplicationIdToVerdicts < ActiveRecord::Migration[6.0]
  def change
    add_column :verdicts, :application_id, :uuid
  end
end
