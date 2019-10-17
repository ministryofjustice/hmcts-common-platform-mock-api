class LegalEntityDefendant < ApplicationRecord
  belongs_to :organisation
  validates :organisation, presence: true

  def to_builder
    Jbuilder.new do |legal_entity_defendant|
      legal_entity_defendant.organisation organisation.to_builder
    end

  end
end
