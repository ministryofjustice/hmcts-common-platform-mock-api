# frozen_string_literal: true

class ProsecutionCaseCourtApplicationSummary
  include ActiveModel::Model
  include BuilderMappable

  attr_reader :court_application
  attr_accessor :court_application_id

  def initialize(attributes = {})
    super
    @court_application ||= CourtApplication.find(attributes[:court_application_id])
  end

  def to_builder
    Jbuilder.new do |application_case_summary|
      application_case_summary.applicationId court_application_id
      application_case_summary.laaApplicationShortId court_application.short_code
      application_case_summary.applicationReference court_application.applicationReference
      application_case_summary.applicationTitle court_application.court_application_type.type
      application_case_summary.receivedDate court_application.applicationReceivedDate.to_date
      application_case_summary.subjectSummary defendants_builder if @court_application.defendant.present?
    end
  end

private

  def prosecution_case_reference
    prosecution_case.prosecution_case_identifier.caseURN || prosecution_case.prosecution_case_identifier.prosecutionAuthorityReference
  end

  def defendants_builder
    CourtApplicationDefendantSummary.new(defendant_id: @court_application.defendant.id).to_builder.attributes!
  end
end
