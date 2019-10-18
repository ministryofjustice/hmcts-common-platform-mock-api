class Offence < ApplicationRecord
  belongs_to :notified_plea, optional: true
  belongs_to :indicated_plea, optional: true
  belongs_to :allocation_decision, optional: true
  belongs_to :plea, optional: true
  belongs_to :verdict, optional: true
  belongs_to :offence_facts, optional: true
  belongs_to :custody_time_limit, optional: true

  has_many :victims, class_name: 'Person'
  has_many :judicial_results
  has_many :laa_references

  validates :offenceDefinitionId, presence: true
  validates :offenceCode, presence: true
  validates :offenceTitle, presence: true
  validates :wording, presence: true
  validates :startDate, presence: true

  def to_builder
    Jbuilder.new do |offence|
      offence.id id
      offence.offenceDefinitionId offenceDefinitionId
      offence.offenceCode offenceCode
      offence.offenceTitle offenceTitle
      offence.offenceTitleWelsh offenceTitleWelsh
      offence.offenceLegislation offenceLegislation
      offence.offenceLegislationWelsh offenceLegislationWelsh
      offence.modeOfTrial modeOfTrial
      offence.wording wording
      offence.wordingWelsh wordingWelsh
      offence.startDate startDate.to_date
      offence.endDate endDate.to_date
      offence.arrestDate arrestDate.to_date
      offence.chargeDate chargeDate.to_date
      offence.dateOfInformation dateOfInformation.to_date
      offence.orderIndex orderIndex
      offence.count count
      offence.convictionDate convictionDate.to_date
      offence.notifiedPlea notified_plea.to_builder if notified_plea.present?
      offence.indicatedPlea indicated_plea.to_builder if indicated_plea.present?
      offence.allocationDecision allocation_decision.to_builder if allocation_decision.present?
      offence.plea plea.to_builder if plea.present?
      offence.verdict verdict.to_builder if verdict.present?
      offence.offenceFacts offence_facts.to_builder if offence_facts.present?
      offence.aquittalDate aquittalDate.to_date
      offence.victims Jbuilder.new.array! victims_builder if victims.present?
      offence.judicialResults Jbuilder.new.array! judicial_results_builder if judicial_results.present?
      offence.isDisposed isDisposed
      offence.isDiscontinued isDiscontinued
      offence.isIntroduceAfterInitialProceedings isIntroduceAfterInitialProceedings
      offence.laaApplnReferences Jbuilder.new.array! laa_references_builder if laa_references.present?
      offence.custodyTimeLimit custody_time_limit.to_builder if custody_time_limit.present?
      offence.splitProsecutorCaseReference splitProsecutorCaseReference
      offence.mergedProsecutionCaseReference mergedProsecutionCaseReference
    end
  end

  private
    def victims_builder
      victims.map do |victim|
        victim.to_builder.attributes!
      end
    end

    def judicial_results_builder
      judicial_results.map do |judicial_result|
        judicial_result.to_builder.attributes!
      end
    end

    def laa_references_builder
      laa_references.map do |laa_reference|
        laa_reference.to_builder.attributes!
      end
    end
end
