class UpdateProsecutionCase < ActiveRecord::Migration[6.0]
  def change
    change_table :prosecution_cases do |t|
      t.string :class_of_case
      t.boolean :is_cps_org_verify_error
      t.string :summons_code
    end
  end
end
