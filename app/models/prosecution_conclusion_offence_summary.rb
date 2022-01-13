class ProsecutionConclusionOffenceSummary
  include ActiveModel::Model

  attr_reader :offence

  def initialize(offence:)
    @offence = offence
  end

  def to_builder
    Jbuilder.new do |offence_summary|
      offence_summary.offenceId offence.id
      offence_summary.offenceCode offence.offenceCode
      offence_summary.proceedingsConcluded offence.proceedingsConcluded
      offence_summary.proceedingsConcludedChangedDate "2021-12-17"
      offence_summary.plea build_plea if offence.pleas.present?
      offence_summary.verdict build_verdict if offence.verdicts.present?
    end
  end

private

  def build_plea
    plea = offence.pleas.first

    {
      originatingHearingId: plea.hearing_id,
      value: plea.pleaValue,
      pleaDate: plea.pleaDate,
    }
  end

  def build_verdict
    verdict = offence.verdicts.first

    {
      originatingHearingId: verdict.hearing_id,
      verdictDate: verdict.verdictDate,
      verdictType: verdict_type_builder,
    }
  end

  def verdict_type_builder
    verdict = offence.verdicts.first

    {
      verdictTypeId: verdict.verdict_type.id,
      description: verdict.verdict_type.description,
      category: verdict.verdict_type.category,
      categoryType: verdict.verdict_type.categoryType,
      sequence: verdict.verdict_type.sequence,
    }
  end
end
