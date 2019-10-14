class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people, id: :uuid do |t|
      t.string :title
      t.string :firstName
      t.string :middleName
      t.string :lastName
      t.datetime :dateOfBirth
      t.uuid :nationalityId
      t.string :nationalityCode
      t.string :nationalityDescription
      t.uuid :additionalNationalityId
      t.string :additionalNationalityCode
      t.string :additionalNationalityDescription
      t.string :disabilityStatus
      t.references :ethnicity, type: :uuid, foreign_key: true
      t.string :gender
      t.string :interpreterLanguageNeeds
      t.string :documentationLanguageNeeds
      t.string :nationalInsuranceNumber
      t.string :occupation
      t.string :occupationCode
      t.string :specificRequirements

      t.timestamps
    end
  end
end
