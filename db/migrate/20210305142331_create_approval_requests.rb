class CreateApprovalRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :approval_requests, id: :uuid do |t|
      t.uuid :hearing_id
      t.uuid :user_id
      t.string :request_approval_time
      t.string :approval_type

      t.timestamps
    end
  end
end
