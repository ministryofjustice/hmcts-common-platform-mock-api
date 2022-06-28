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
      offence_summary.verdict offence.verdicts.max.to_builder.attributes! if offence.verdicts.present?
      offence_summary.plea build_pleas if offence.pleas.present?
    end
  end

private

  def build_pleas
    offence.pleas.map do |plea|
      plea.to_builder.attributes!
    end
  end
end
