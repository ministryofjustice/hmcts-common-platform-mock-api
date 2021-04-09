class RemoveCourtApplicationField < ActiveRecord::Migration[6.0]
  def change
    change_table :court_applications do |t|
      t.remove :court_centre_id
    end
  end
end
