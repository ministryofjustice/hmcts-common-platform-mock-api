class AddOffenceRelationships < ActiveRecord::Migration[6.0]
  def change
    add_reference :people, :offence, type: :uuid, index: true, foreign_key: true
    add_reference :judicial_results, :offence, type: :uuid, index: true, foreign_key: true
    add_reference :laa_references, :offence, type: :uuid, index: true, foreign_key: true
  end
end
