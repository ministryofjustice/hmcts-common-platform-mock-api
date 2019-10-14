class CreateAllocationDecisions < ActiveRecord::Migration[6.0]
  def change
    create_table :allocation_decisions, id: :uuid do |t|
      t.uuid :originatingHearingId
      t.uuid :offenceId
      t.uuid :motReasonId
      t.string :motReasonDescription
      t.integer :motReasonCode
      t.datetime :allocationDecisionDate
      t.boolean :isSection22ALowValueShoplifting, default: false, null: false
      t.boolean :isDamageValueUnder5000, default: false, null: false
      t.boolean :isTreatedAsIndictableOnly, default: false, null: false
      t.boolean :sentencingIndicationRequested, default: false, null: false
      t.references :court_indicated_sentence, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
