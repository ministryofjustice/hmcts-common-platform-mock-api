# frozen_string_literal: true

class CourtApplicationSummary
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
      application_case_summary.applicationStatus court_application.applicationStatus
      application_case_summary.applicationTitle court_application.court_application_type.type
      application_case_summary.applicationType court_application.court_application_type.code
      application_case_summary.receivedDate court_application.applicationReceivedDate.to_date
      application_case_summary.applicationResult court_application.result_code
      application_case_summary.caseSummary prosecution_cases_builder if @court_application.prosecution_cases.present?
      application_case_summary.hearingSummary hearings_builder if @court_application.hearing.present?
      application_case_summary.judicialResults court_application.judicial_results if @court_application.judicial_results.present?
      application_case_summary.subjectSummary defendants_builder if @court_application.defendant.present?
    end
  end

private

  def prosecution_cases_builder
    court_application.prosecution_cases.ids.map do |prosecution_case_id|
      CourtApplicationProsecutionCaseSummary.new(prosecution_case_id:).to_builder.attributes!
    end
  end

  def hearings_builder
    court_application.court_hearings.map do |hearing|
      HearingSummary.new(hearing:).to_builder.attributes!
    end
  end

  def defendants_builder
    CourtApplicationDefendantSummary.new(defendant_id: @court_application.defendant.id).to_builder.attributes!
  end
end
