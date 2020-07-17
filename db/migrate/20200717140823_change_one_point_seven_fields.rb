class ChangeOnePointSevenFields < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :attendance_days, :interpreter_intermediaries
    remove_foreign_key :attendance_days, :company_representatives
    remove_foreign_key :defendants, :company_representatives
    remove_foreign_key :person_defendants, :defendant_custody_locations


    drop_table :interpreter_intermediaries, id: :uuid do |t|
      t.string :role
      t.string :firstName
      t.string :lastName
      t.references :attendant, type: :uuid, null: false, index: true, foreign_key: true
      t.timestamps
      t.references :hearing, type: :uuid, index: true, foreign_key: true
    end

    drop_table :attendants, id: :uuid do |t|
      t.string :attendantType
      t.string :name
      t.references :defendant, type: :uuid, index: true, foreign_key: true
      t.timestamps
    end

    drop_table :company_representatives, id: :uuid do |t|
      t.string :title
      t.string :firstName
      t.string :lastName
      t.string :position
      t.timestamps
      t.references :hearing, type: :uuid, index: true, foreign_key: true
    end

    drop_table :defendant_custody_locations, id: :uuid do |t|
      t.string :name
      t.references :address, type: :uuid, null: false, index: true, foreign_key: true
      t.string :emailAddress
      t.string :locationType
      t.timestamps
    end

    drop_table :defendant_judicial_results, id: :uuid do |t|
      t.uuid :masterDefendantId
      t.references :judicial_result, type: :uuid, null: false, index: true, foreign_key: true
      t.timestamps
      t.references :hearing, type: :uuid, index: true, foreign_key: true
    end

    drop_table :lja_details, id: :uuid do |t|
      t.string :ljaCode
      t.string :ljaName
      t.string :welshLjaName
      t.timestamps
    end

    remove_column :attendance_days, :isInAttendance, :boolean, default: false, null: false
    remove_column :attendance_days, :byVideoLinkFromCustodyLocation, :boolean, default: false, null: false
    add_column :attendance_days, :attendanceType, :string
    add_column :allocation_decisions, :sequenceNumber, :integer, default: 0, null: false

    reversible do |dir|
      dir.up do
        change_column :allocation_decisions, :motReasonCode, :string
      end
      dir.down do
        change_column :allocation_decisions, :motReasonCode, :integer, using: '"motReasonCode"::integer'
      end
    end
  end
end
