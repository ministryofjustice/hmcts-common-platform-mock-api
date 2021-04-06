class UpdateOffence < ActiveRecord::Migration[6.0]
  def change
    change_table :offences do |t|
      t.string :dvla_offence_code
      t.references :committing_court
      t.integer :offence_date_code
    end

    change_table :reporting_restrictions do |t|
      t.belongs_to :offence
    end
  end
end
