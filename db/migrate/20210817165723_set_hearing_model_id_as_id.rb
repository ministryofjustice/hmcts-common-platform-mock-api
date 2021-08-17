class SetHearingModelIdAsId < ActiveRecord::Migration[6.0]
  def change
    Hearing.update_all("hearing_id=id")
  end
end
