class CreateCourtApplicationPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :court_application_payments, id: :uuid do |t|
      t.boolean :isFeePaid
      t.boolean :isFeeUndertakingAttached
      t.boolean :isFeeExempt
      t.string :paymentReference

      t.timestamps
    end
  end
end
