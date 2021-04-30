class CreateReportingRestrictions < ActiveRecord::Migration[6.0]
  def change
    create_table :reporting_restrictions, id: :uuid do |t|
      t.uuid :judicial_result_id
      t.string :label
      t.string :ordered_date

      t.timestamps
    end
  end
end
