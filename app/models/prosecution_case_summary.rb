# frozen_string_literal: true

class ProsecutionCaseSummary
  include ActiveModel::Model

  attr_reader :prosecution_case
  attr_accessor :prosecution_case_id

  def initialize(attributes = {})
    super
    @prosecution_case ||= ProsecutionCase.find(attributes[:prosecution_case_id])
  end

  def to_builder
    Jbuilder.new do |prosecution_case_summary|
      prosecution_case_summary.prosecutionCaseId prosecution_case_id
      prosecution_case_summary.prosecutionCaseReference prosecution_case_reference
      prosecution_case_summary.caseStatus prosecution_case.caseStatus
      prosecution_case_summary.defendantSummary defendants_builder
      prosecution_case_summary.hearingSummary hearings_builder if prosecution_case.hearings.present?
    end
  end

private

  def prosecution_case_reference
    prosecution_case.prosecution_case_identifier.caseURN || prosecution_case.prosecution_case_identifier.prosecutionAuthorityReference
  end

  def hearings_builder
    prosecution_case.hearings.map { |hearing| HearingSummary.new(hearing_id: hearing.id).to_builder.attributes! }
  end

  def defendants_builder
    prosecution_case.defendants.map do |defendant|
      DefendantSummary.new(defendant_id: defendant.id).to_builder.attributes!
    end
  end
end
