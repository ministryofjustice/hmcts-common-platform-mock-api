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
      offence_summary.verdict build_verdict.first if offence.verdicts.present?
      offence_summary.plea build_pleas if offence.pleas.present?
    end
  end
  
  def build_verdict
    offence.verdicts.map do |verdict|
      [
        [:verdictDate, verdict.verdictDate],
        [:originatingHearingId, verdict.hearing_id],
        [:verdictType, verdict_type_builder.first],
      ].to_h
    end
  end

  def verdict_type_builder
    offence.verdicts.map do |verdict|
      [
        [:description, verdict.verdict_type.description],
        [:category, verdict.verdict_type.category],
        [:categoryType, verdict.verdict_type.categoryType],
        [:sequence, verdict.verdict_type.sequence],
        [:verdictTypeId, verdict.verdict_type.id],
        
private

  def build_pleas
    offence.pleas.map do |plea|
      [
        [:originatingHearingId, plea.hearing_id],
        [:value, plea.pleaValue],
        [:pleaDate, plea.pleaDate],
      ].to_h
    end
  end
end
