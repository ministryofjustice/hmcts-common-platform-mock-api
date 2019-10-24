class CreateCrackedIneffectiveTrials < ActiveRecord::Migration[6.0]
  def change
    create_table :cracked_ineffective_trials, id: :uuid do |t|
      t.string :code
      t.string :description
      t.string :reason_type

      t.timestamps
    end
  end
end
