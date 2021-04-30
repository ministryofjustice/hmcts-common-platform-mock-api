class UpdatePlea < ActiveRecord::Migration[6.0]
  def change
    change_table :pleas do |t|
      t.uuid :application_id
      t.references :lesser_or_alternative_offence
    end
  end
end
