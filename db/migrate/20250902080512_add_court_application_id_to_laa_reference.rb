class AddCourtApplicationIdToLaaReference < ActiveRecord::Migration[8.0]
  def change
    add_reference :laa_references, :court_application, null: true, foreign_key: true, type: :uuid
  end
end
