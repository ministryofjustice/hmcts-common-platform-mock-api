class CreateProsecutionCaseHearings < ActiveRecord::Migration[6.0]
  def change
    create_table :prosecution_case_hearings, id: :uuid do |t|
      t.references :prosecution_case, type: :uuid, null: false, foreign_key: true
      t.references :hearing, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
    reversible do |dir|
      dir.up do
        execute <<-SQL
        INSERT INTO prosecution_case_hearings (prosecution_case_id, hearing_id, created_at, updated_at)
        SELECT id, hearing_id, created_at, updated_at
        FROM prosecution_cases
        WHERE hearing_id IS NOT NULL;
        SQL
      end
    end

    remove_reference :prosecution_cases, :hearing, type: :uuid, foreign_key: true
  end
end
