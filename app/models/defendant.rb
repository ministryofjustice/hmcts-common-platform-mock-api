# frozen_string_literal: true

class Defendant < ApplicationRecord
  include BuilderMappable
  belongs_to :defendable, polymorphic: true
  belongs_to :prosecution_case, inverse_of: :defendants
  has_many :offences, dependent: :destroy
  has_many :laa_references, through: :offences
  has_many :associated_people, dependent: :destroy
  has_one :defence_organisation, dependent: :destroy
  has_many :defendant_aliases, dependent: :destroy
  has_many :judicial_results, dependent: :destroy
  has_many :markers, dependent: :destroy
  has_many :split_prosecutor_case_references, dependent: :destroy
  has_many :linked_defendants, dependent: :destroy

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

  scope :by_name, lambda { |name|
    left_outer_joins(:legal_entity_defendant, :person_defendant).where(
      'legal_entity_defendants.organisation_id IN (:organisation_ids)
      OR person_defendants.person_id IN (:person_ids)',
      {
        organisation_ids: Organisation.by_name(name).ids,
        person_ids: Person.by_name(name).ids
      }
    )
  }

  scope :by_date_of_next_hearing, lambda { |date|
    joins(judicial_results: :next_hearing).where(next_hearings: { listedStartDateTime: date.to_date.all_day })
  }

  accepts_nested_attributes_for :defendable, reject_if: :all_blank
  accepts_nested_attributes_for :offences, reject_if: :all_blank, allow_destroy: true

  def build_defendable(params)
    self.defendable = defendable_type.constantize.new(params)
  end

  def person?
    defendable.is_a? PersonDefendant
  end

  def legal_entity?
    defendable.is_a? LegalEntityDefendant
  end

  def name
    return defendable.organisation.name if legal_entity?

    [defendable.person.first_name, defendable.person.middle_name, defendable.person.last_name].compact.join(' ')
  end

  def to_builder(hearing: nil)
    Jbuilder.new do |defendant|
      defendant.id id
      defendant.prosecutionCaseId prosecution_case_id
      defendant.masterDefendantId masterDefendantId
      defendant.courtProceedingsInitiated courtProceedingsInitiated.to_datetime if courtProceedingsInitiated.present?
      defendant.numberOfPreviousConvictionsCited numberOfPreviousConvictionsCited
      defendant.prosecutionAuthorityReference prosecutionAuthorityReference
      defendant.witnessStatement witnessStatement
      defendant.witnessStatementWelsh witnessStatementWelsh
      defendant.mitigation mitigation
      defendant.mitigationWelsh mitigationWelsh
      defendant.offences array_builder(offences, hearing: hearing)
      defendant.associatedPersons array_builder(associated_people)
      defendant.defenceOrganisation defence_organisation.organisation.to_builder if defence_organisation.present?
      defendant.associatedDefenceOrganisation defence_organisation.to_builder if defence_organisation.present?
      defendant.personDefendant defendable.to_builder if person?
      defendant.legalEntityDefendant defendable.to_builder if legal_entity?
      defendant.aliases array_builder(defendant_aliases)
      defendant.croNumber croNumber
      defendant.pncId pncId
    end
  end
end
