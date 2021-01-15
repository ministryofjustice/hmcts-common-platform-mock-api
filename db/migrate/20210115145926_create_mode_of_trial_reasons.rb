class CreateModeOfTrialReasons < ActiveRecord::Migration[6.0]
  def change
    create_table :mode_of_trial_reasons, id: :uuid do |t|
      t.integer :seq_number
      t.integer :reason_code
      t.string :reason_description

      t.timestamps
    end
  end
end
