class Defendant < ApplicationRecord
  belongs_to :defendable, polymorphic: true
  has_many :offences
  has_many :associated_people
  has_many :associated_defence_organisations
  has_many :defendant_aliases
  has_many :judicial_results
  has_many :markers
  has_many :split_prosecutor_case_references
  has_many :linked_defendants

  validates :prosecutionCaseId, presence: true
  validates :offences, presence: true
  validates :defendable, presence: true
  validates :split_prosecutor_case_references, length: { minimum: 2 }, if: -> { split_prosecutor_case_references.present? }

  def to_builder
    Jbuilder.new do |defendant|
      defendant.id id
      defendant.prosecutionCaseId prosecutionCaseId
      defendant.numberOfPreviousConvictionsCited numberOfPreviousConvictionsCited
      defendant.prosecutionAuthorityReference prosecutionAuthorityReference
      defendant.witnessStatement witnessStatement
      defendant.witnessStatementWelsh witnessStatementWelsh
      defendant.mitigation mitigation
      defendant.mitigationWelsh mitigationWelsh
      defendant.offences Jbuilder.new.array! offences_builder
      defendant.associatedPersons Jbuilder.new.array! associated_people_builder if associated_people.present?
      if associated_defence_organisations.present?
        defendant.associatedDefenceOrganisations Jbuilder.new.array! associated_defence_organisations_builder
      end
      defendant.personDefendant defendable.to_builder if person_defendant?
      defendant.legalEntityDefendant defendable.to_builder if legal_entity_defendant?
      defendant.aliases Jbuilder.new.array! defendant_aliases_builder if defendant_aliases.present?
      defendant.judicialResults Jbuilder.new.array! judicial_results_builder if judicial_results.present?
      defendant.croNumber croNumber
      defendant.pncId pncId
      defendant.defendantMarkers Jbuilder.new.array! markers_builder if markers.present?
      if split_prosecutor_case_references.present?
        defendant.splitProsecutorCaseReferences Jbuilder.new.array! split_prosecutor_case_references_builder
      end
      defendant.mergedProsecutionCaseReference mergedProsecutionCaseReference
      defendant.linkedDefendants Jbuilder.new.array! linked_defendants_builder if linked_defendants.present?
    end
  end

  private

  def offences_builder
    offences.map do |offence|
      offence.to_builder.attributes!
    end
  end

  def associated_people_builder
    associated_people.map do |associated_person|
      associated_person.to_builder.attributes!
    end
  end

  def associated_defence_organisations_builder
    associated_defence_organisations.map do |associated_defence_organisation|
      associated_defence_organisation.to_builder.attributes!
    end
  end

  def defendant_aliases_builder
    defendant_aliases.map do |defendant_alias|
      defendant_alias.to_builder.attributes!
    end
  end

  def judicial_results_builder
    judicial_results.map do |judicial_result|
      judicial_result.to_builder.attributes!
    end
  end

  def markers_builder
    markers.map do |marker|
      marker.to_builder.attributes!
    end
  end

  def split_prosecutor_case_references_builder
    split_prosecutor_case_references.map(&:split)
  end

  def linked_defendants_builder
    linked_defendants.map do |linked_defendant|
      linked_defendant.to_builder.attributes!
    end
  end

  def person_defendant?
    defendable.is_a? PersonDefendant
  end

  def legal_entity_defendant?
    defendable.is_a? LegalEntityDefendant
  end
end
