# frozen_string_literal: true

class ProsecutionCase < ApplicationRecord
  include BuilderMappable
  INITIATION_CODES = %w[J Q S C R O Z].freeze
  CASE_STATUSES = %w[ACTIVE INACTIVE].freeze

  belongs_to :prosecution_case_identifier
  belongs_to :police_officer_in_case, optional: true
  belongs_to :merged_prosecution_case, optional: true
  belongs_to :hearing, optional: true, inverse_of: :prosecution_cases

  has_many :defendants, dependent: :destroy, inverse_of: :prosecution_case
  has_many :person_only_defendants, -> { people_only }, class_name: 'Defendant'
  has_many :legal_entity_only_defendants, -> { legal_entity_only }, class_name: 'Defendant'
  has_many :markers, dependent: :destroy
  has_many :split_prosecutor_case_references, dependent: :destroy
  has_many :linked_prosecution_cases, dependent: :destroy
  has_many :prosecution_case_hearing_case_notes, dependent: :destroy
  has_many :hearing_case_notes, through: :prosecution_case_hearing_case_notes

  validates :prosecution_case_identifier, presence: true
  validates :initiationCode, presence: true, inclusion: INITIATION_CODES
  validates :defendants, presence: true
  validates :caseStatus, presence: true, inclusion: CASE_STATUSES
  validates :split_prosecutor_case_references, length: { minimum: 2 }, if: -> { split_prosecutor_case_references.present? }

  def to_builder
    Jbuilder.new do |prosecution_case|
      prosecution_case.id id
      prosecution_case.prosecutionCaseIdentifier prosecution_case_identifier.to_builder
      prosecution_case.originatingOrganisation originatingOrganisation
      prosecution_case.initiationCode initiationCode
      prosecution_case.caseStatus caseStatus
      prosecution_case.policeOfficerInCase police_officer_in_case.to_builder if police_officer_in_case.present?
      prosecution_case.statementOfFacts statementOfFacts
      prosecution_case.statementOfFactsWelsh statementOfFactsWelsh
      prosecution_case.breachProceedingsPending breachProceedingsPending
      prosecution_case.appealProceedingsPending appealProceedingsPending
      prosecution_case.defendants array_builder(defendants)
      prosecution_case.caseMarkers array_builder(markers)
      prosecution_case.splitProsecutorCaseReferences split_prosecutor_case_references_builder
      prosecution_case.mergedProsecutionCase merged_prosecution_case.to_builder if merged_prosecution_case.present?
      prosecution_case.linkedProsecutionCases collection_ids(linked_prosecution_cases)
    end
  end
end
