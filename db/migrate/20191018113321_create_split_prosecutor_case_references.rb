class CreateSplitProsecutorCaseReferences < ActiveRecord::Migration[6.0]
  def change
    create_table :split_prosecutor_case_references, id: :uuid do |t|
      t.string :split

      t.timestamps
    end
  end
end
