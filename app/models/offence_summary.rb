# frozen_string_literal: true

class OffenceSummary
  include ActiveModel::Model

  attr_reader :offence
  attr_accessor :offence_id

  def initialize(attributes = {})
    super
    @offence ||= Offence.find(attributes[:offence_id])
  end

  def to_builder
    Jbuilder.new do |offence_summary|
      offence_summary.offenceId offence_id
      offence_summary.offenceCode offence.offenceCode
      offence_summary.orderIndex offence.orderIndex
      offence_summary.offenceTitle offence.offenceTitle
      offence_summary.offenceLegislation offence.offenceLegislation
      offence_summary.wording offence.wording
      offence_summary.arrestDate offence.arrestDate.to_date
      offence_summary.chargeDate offence.chargeDate.to_date
      offence_summary.dateOfInformation offence.dateOfInformation.to_date
      offence_summary.modeOfTrial offence.modeOfTrial
      offence_summary.startDate offence.startDate.to_date
      offence_summary.endDate offence.endDate.to_date
      offence_summary.proceedingsConcluded offence.isDisposed
      offence_summary.laaApplnReference offence.laa_reference.to_builder if offence.laa_reference.present?
      offence_summary.verdict build_verdict if offence.verdicts.present?
      offence_summary.plea build_pleas if offence.pleas.present?
    end
  end

  def build_verdict
    latest_verdict = offence.verdicts.max
    {
      originatingHearingId: latest_verdict.hearing,
      offenceId: latest_verdict.offence_id,
      applicationId: latest_verdict.application_id,
      verdictDate: latest_verdict.verdictDate,
      verdictType: verdict_type_builder,
      jurors: latest_verdict.jurors,
      lesserOrAlternativeOffence: latest_verdict.lesser_or_alternative_offence,
    }
  end

  def verdict_type_builder
    offence.verdicts.max
  end

private

  def build_pleas
    latest_plea = offence.pleas.max
    { originatingHearingId: latest_plea.id,
      delegatedPowers: latest_plea.delegated_powers,
      offenceId: latest_plea.offence_id,
      applicationId: latest_plea.application_id,
      pleaDate: latest_plea.pleaDate,
      pleaValue: latest_plea.pleaValue,
      lesserOrAlternativeOffence: latest_plea.lesser_or_alternative_offence_id }
  end
end
