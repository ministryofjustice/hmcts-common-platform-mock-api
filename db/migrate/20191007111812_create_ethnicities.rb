class CreateEthnicities < ActiveRecord::Migration[6.0]
  def change
    create_table :ethnicities, id: :uuid do |t|
      t.uuid :observedEthnicityId
      t.string :observedEthnicityCode
      t.string :observedEthnicityDescription
      t.uuid :selfDefinedEthnicityId
      t.string :selfDefinedEthnicityCode
      t.string :selfDefinedEthnicityDescription

      t.timestamps
    end
  end
end
