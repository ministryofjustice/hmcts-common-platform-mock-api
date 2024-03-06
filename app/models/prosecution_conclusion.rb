class ProsecutionConclusion
  include ActiveModel::Model

  attr_reader :defendant

  def initialize(defendant:)
    @defendant = defendant
  end

  def to_builder
    Jbuilder.new do |prosecution_conclusion|
      prosecution_conclusion.prosecutionCaseId defendant.prosecution_case.id
      prosecution_conclusion.defendantId defendant.id
      prosecution_conclusion.isConcluded true
      prosecution_conclusion.hearingIdWhereChangeOccurred defendant.prosecution_case.hearings.last.id
      prosecution_conclusion.offenceSummary offence_summary_builder
    end
  end

private

  def offence_summary_builder
    defendant.offences.map do |offence|
      ProsecutionConclusionOffenceSummary.new(offence:).to_builder.attributes!
    end
  end
end
