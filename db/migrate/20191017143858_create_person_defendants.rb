class CreatePersonDefendants < ActiveRecord::Migration[6.0]
  def change
    create_table :person_defendants, id: :uuid do |t|
      t.references :person, type: :uuid, null: false, foreign_key: true
      t.references :bail_status, type: :uuid, foreign_key: true
      t.string :bailConditions
      t.string :bailReasons
      t.datetime :custodyTimeLimit
      t.integer :perceivedBirthYear
      t.string :driverNumber
      t.string :driverLicenceCode
      t.string :driverLicenseIssue
      t.string :vehicleOperatorLicenceNumber
      t.string :arrestSummonsNumber
      t.references :employer_organisation, type: :uuid, foreign_key: { to_table: :organisations }
      t.string :employerPayrollReference

      t.timestamps
    end
  end
end
