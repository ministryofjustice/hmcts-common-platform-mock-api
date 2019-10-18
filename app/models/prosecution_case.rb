class ProsecutionCase < ApplicationRecord
  INITIATION_CODES = %w[J Q S C R O Z].freeze
  CASE_STATUSES = %w[ACTIVE INACTIVE].freeze

  belongs_to :prosecution_case_identifier
  belongs_to :police_officer_in_case, optional: true
  belongs_to :merged_prosecution_case, optional: true

  has_many :defendants
  has_many :markers
  has_many :split_prosecutor_case_references
  has_many :linked_prosecution_cases

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
      prosecution_case.defendants Jbuilder.new.array! defendants_builder
      prosecution_case.caseMarkers Jbuilder.new.array! markers_builder if markers.present?
      if split_prosecutor_case_references.present?
        prosecution_case.splitProsecutorCaseReferences Jbuilder.new.array! split_prosecutor_case_references_builder
      end
      prosecution_case.mergedProsecutionCase merged_prosecution_case.to_builder if merged_prosecution_case.present?
      prosecution_case.linkedProsecutionCases Jbuilder.new.array! linked_prosecution_cases_builder if linked_prosecution_cases.present?
    end
  end

  private

  def defendants_builder
    defendants.map do |defendant|
      defendant.to_builder.attributes!
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

  def linked_prosecution_cases_builder
    linked_prosecution_cases.ids
  end
end
