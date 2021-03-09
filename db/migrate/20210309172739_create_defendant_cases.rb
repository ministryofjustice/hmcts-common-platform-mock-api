class CreateDefendantCases < ActiveRecord::Migration[6.0]
  def change
    create_table :defendant_cases, id: :uuid do |t|
      t.uuid :defendant_id
      t.uuid :case_id
      t.string :case_reference

      t.timestamps
    end
  end
end
