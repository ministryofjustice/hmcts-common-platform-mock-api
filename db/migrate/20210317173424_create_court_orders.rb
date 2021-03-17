class CreateCourtOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :court_orders, id: :uuid do |t|
      t.text :defendant_ids, array: true, default: []
      t.uuid :master_defendant_id
      t.uuid :judicial_result_type_id
      t.string :label
      t.string :order_date
      t.string :start_date
      t.string :end_date
      t.uuid :court_centre_id
      t.uuid :ordering_hearing_id
      t.boolean :is_sjp_order
      t.boolean :can_be_subject_of_breach_proceedings
      t.boolean :can_be_subject_of_variation_proceedings

      t.timestamps
    end

    change_table :court_order_offences do |t|
      t.belongs_to :court_order
    end
  end
end
