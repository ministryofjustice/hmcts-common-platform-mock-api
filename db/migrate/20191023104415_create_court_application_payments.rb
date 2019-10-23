class CreateCourtApplicationPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :court_application_payments, id: :uuid do |t|
      t.boolean :isFeePaid, default: false, null: false
      t.boolean :isFeeUndertakingAttached, default: false, null: false
      t.boolean :isFeeExempt, default: false, null: false
      t.string :paymentReference

      t.timestamps
    end
  end
end
