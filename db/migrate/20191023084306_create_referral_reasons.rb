class CreateReferralReasons < ActiveRecord::Migration[6.0]
  def change
    create_table :referral_reasons, id: :uuid do |t|
      t.string :description
      t.uuid :defendantId

      t.timestamps
    end
  end
end
