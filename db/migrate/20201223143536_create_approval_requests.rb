class CreateApprovalRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :approval_requests, id: :uuid do |t|
      t.references :hearing, type: :uuid, null: false, foreign_key: true
      t.uuid :userId
      t.datetime :requestApprovalTime
      t.string :approvalType

      t.timestamps
    end
  end
end
