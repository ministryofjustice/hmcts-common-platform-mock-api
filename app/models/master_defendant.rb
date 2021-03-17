class MasterDefendant < ApplicationRecord
  include BuilderMappable
  belongs_to :person_defendant
  belongs_to :legal_entity_defendant
  has_many :associated_people
  has_many :defendant_cases

  validates :master_defendant_id, presence: true

  def to_builder
    Jbuilder.new do |master_defendant|
      master_defendant.masterDefendantId master_defendant_id
      master_defendant.personDefendant person_defendant.to_builder
      master_defendant.legalEntityDefendant legal_entity_defendant.to_builder
      master_defendant.associatedPersons array_builder(associated_people)
      master_defendant.isYouth is_youth
      master_defendant.pncId pnc_id
      master_defendant.prosecutionAuthorityReference prosecution_authority_reference
      master_defendant.defendantCase array_builder(defendant_cases)
    end
  end
end
