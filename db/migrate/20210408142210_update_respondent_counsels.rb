class UpdateRespondentCounsels < ActiveRecord::Migration[6.0]
  def change
    change_table :respondent_counsels do |t|
      t.uuid :respondents, array: true, default: []
    end
  end
end
