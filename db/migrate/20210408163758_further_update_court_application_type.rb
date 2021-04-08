class FurtherUpdateCourtApplicationType < ActiveRecord::Migration[6.0]
  def change
    change_table :court_application_types do |t|
      t.string :code
      t.string :legislation
      t.string :valid_from
      t.string :valid_to
      t.string :listing_notif_template
      t.string :boxwork_notif_template
      t.string :type_welsh
      t.string :legislation_welsh
      t.string :hearing_code
      t.string :resentencing_activation_code
      t.string :prefix
    end
  end
end
