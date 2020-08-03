class ChangeOffenceCodeValue < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        execute 'UPDATE offences SET "offenceCode" = \'PT00011\';'
        execute 'UPDATE lesser_or_alternative_offences SET "offenceCode" = \'PT00011\';'
      end
    end
  end
end
