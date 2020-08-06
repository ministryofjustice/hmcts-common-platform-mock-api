class AddResultedToHearings < ActiveRecord::Migration[6.0]
  def change
    add_column :hearings, :resulted, :boolean, default: false, null: false
  end
end
