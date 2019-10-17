class CreateLaaReferences < ActiveRecord::Migration[6.0]
  def change
    create_table :laa_references, id: :uuid do |t|
      t.string :applicationReference
      t.uuid :statusId
      t.string :statusCode
      t.string :statusDescription
      t.datetime :statusDate
      t.datetime :effectiveStartDate
      t.datetime :effectiveEndDate

      t.timestamps
    end
  end
end
