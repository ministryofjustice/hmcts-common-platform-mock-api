class CreateSeedingHearings < ActiveRecord::Migration[6.0]
  def change
    create_table :seeding_hearings, id: :uuid do |t|
      t.uuid :seeding_hearing_id
      t.string :jurisdiction_type
      t.string :sitting_day

      t.timestamps
    end
  end
end
