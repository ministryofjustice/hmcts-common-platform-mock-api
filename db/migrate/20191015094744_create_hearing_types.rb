class CreateHearingTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :hearing_types, id: :uuid do |t|
      t.string :description
      t.string :code

      t.timestamps
    end
  end
end
