# frozen_string_literal: true

class Defendant < ApplicationRecord
  include BuilderMappable
  belongs_to :defendable, polymorphic: true
  belongs_to :prosecution_case, inverse_of: :defendants
  has_many :offences
  has_many :associated_people
  has_many :defence_organisations
  has_many :defendant_aliases
  has_many :judicial_results
  has_many :markers
  has_many :split_prosecutor_case_references
  has_many :linked_defendants

  belongs_to :person_defendant,
             -> { where(defendants: { defendable_type: 'PersonDefendant' }) },
             class_name: 'PersonDefendant',
             foreign_key: 'defendable_id',
             optional: true

  belongs_to :legal_entity_defendant,
             -> { where(defendants: { defendable_type: 'LegalEntityDefendant' }) },
             class_name: 'LegalEntityDefendant',
             foreign_key: 'defendable_id',
             optional: true

  validates :prosecution_case, presence: true
  validates :offences, presence: true
  validates :defendable, presence: true
  validates :split_prosecutor_case_references, length: { minimum: 2 }, if: -> { split_prosecutor_case_references.present? }

  scope :people_only, -> { joins(:person_defendant) }
  scope :legal_entity_only, -> { joins(:legal_entity_defendant) }

  scope :by_name, lambda { |params|
    return joins(legal_entity_defendant: :organisation).merge(Organisation.by_name(params)) if params.dig(:organisationName).present?

    joins(person_defendant: :person).merge(Person.by_name(params))
  }

  scope :by_date_of_next_hearing, lambda { |date|
    joins(judicial_results: :next_hearing).where(next_hearings: { listedStartDateTime: date })
  }

  def person?
    defendable.is_a? PersonDefendant
  end

  def legal_entity?
    defendable.is_a? LegalEntityDefendant
  end

  def to_builder
    Jbuilder.new do |defendant|
      defendant.id id
      defendant.prosecutionCaseId prosecution_case_id
      defendant.numberOfPreviousConvictionsCited numberOfPreviousConvictionsCited
      defendant.prosecutionAuthorityReference prosecutionAuthorityReference
      defendant.witnessStatement witnessStatement
      defendant.witnessStatementWelsh witnessStatementWelsh
      defendant.mitigation mitigation
      defendant.mitigationWelsh mitigationWelsh
      defendant.offences array_builder(offences)
      defendant.associatedPersons array_builder(associated_people)
      defendant.associatedDefenceOrganisations array_builder(defence_organisations)
      defendant.personDefendant defendable.to_builder if person?
      defendant.legalEntityDefendant defendable.to_builder if legal_entity?
      defendant.aliases array_builder(defendant_aliases)
      defendant.judicialResults array_builder(judicial_results)
      defendant.croNumber croNumber
      defendant.pncId pncId
      defendant.defendantMarkers array_builder(markers)
      defendant.splitProsecutorCaseReferences split_prosecutor_case_references_builder
      defendant.mergedProsecutionCaseReference mergedProsecutionCaseReference
      defendant.linkedDefendants array_builder(linked_defendants)
    end
  end
end
