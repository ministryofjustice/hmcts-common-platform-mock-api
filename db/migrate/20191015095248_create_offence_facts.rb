class CreateOffenceFacts < ActiveRecord::Migration[6.0]
  def change
    create_table :offence_facts, id: :uuid do |t|
      t.string :vehicleRegistration
      t.integer :alcoholReadingAmount
      t.string :alcoholReadingMethodCode
      t.string :alcoholReadingMethodDescription
      t.string :vehicleCode

      t.timestamps
    end
  end
end
