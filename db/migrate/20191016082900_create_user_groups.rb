class CreateUserGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :user_groups, id: :uuid do |t|
      t.string :group

      t.timestamps
    end
  end
end
