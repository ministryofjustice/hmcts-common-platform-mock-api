class ApplicationConclusion
  include ActiveModel::Model

  attr_reader :court_application

  delegate :defendant, to: :court_application

  def initialize(court_application:)
    @court_application = court_application
  end

  def to_builder
    Jbuilder.new do |application_conclusion|
      application_conclusion.applicationConcluded conclusion_summary.attributes!
      application_conclusion.isConcluded true
      application_conclusion.hearingIdWhereChangeOccurred defendant.prosecution_case.hearings.last.id
      application_conclusion.offenceSummary offence_summary_builder
    end
  end

private

  def offence_summary_builder
    defendant.offences.map do |offence|
      ProsecutionConclusionOffenceSummary.new(offence:).to_builder.attributes!
    end
  end

  def conclusion_summary
    Jbuilder.new do |conclusion_summary|
      conclusion_summary.applicationId = court_application.id
      conclusion_summary.applicationResultCode = court_application.result_code
      conclusion_summary.subjectId = defendant.id
    end
  end
end
