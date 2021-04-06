class UpdateDefendant < ActiveRecord::Migration[6.0]
  def change
    change_table :defendants do |t|
      t.remove :courtProceedingsInitiated
    end
  end
end
