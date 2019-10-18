class CreateLinkedDefendants < ActiveRecord::Migration[6.0]
  def change
    create_table :linked_defendants, id: :uuid do |t|
      t.uuid :prosecutionCaseId
      t.uuid :defendantId

      t.timestamps
    end
  end
end
