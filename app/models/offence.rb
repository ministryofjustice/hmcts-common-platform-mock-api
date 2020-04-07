# frozen_string_literal: true

class Offence < ApplicationRecord
  include BuilderMappable
  belongs_to :notified_plea, optional: true
  belongs_to :indicated_plea, optional: true
  belongs_to :allocation_decision, optional: true
  belongs_to :plea, optional: true
  belongs_to :verdict, optional: true
  belongs_to :offence_facts, optional: true
  belongs_to :custody_time_limit, optional: true
  belongs_to :defendant, optional: true

  has_many :victims, class_name: 'Person', dependent: :destroy
  has_many :judicial_results, dependent: :destroy
  has_one :laa_reference, dependent: :destroy

  validates :offenceDefinitionId, presence: true
  validates :offenceCode, presence: true
  validates :offenceTitle, presence: true
  validates :wording, presence: true
  validates :startDate, presence: true

  # rubocop:disable Metrics/MethodLength
  def to_builder
    Jbuilder.new do |offence|
      offence.id id
      offence.offenceDefinitionId offenceDefinitionId
      offence.offenceCode offenceCode
      offence.dvlaCode dvlaCode
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
      offence.laidDate laidDate.to_date
      offence.dateOfInformation dateOfInformation.to_date
      offence.orderIndex orderIndex
      offence.count count
      offence.convictionDate convictionDate.to_date
      offence.aquittalDate aquittalDate.to_date
      offence.victims array_builder(victims)
      offence.judicialResults array_builder(judicial_results)
      offence.isDiscontinued isDiscontinued
      offence.introducedAfterInitialProceedings isIntroduceAfterInitialProceedings
      offence.splitProsecutorCaseReference splitProsecutorCaseReference
      offence.proceedingsConcluded proceedingsConcluded
      offence.pendingCBPW pendingCBPW
      offence.civilOffence civilOffence
      offence.notifiedPlea notified_plea&.to_builder
      offence.indicatedPlea indicated_plea&.to_builder
      offence.allocationDecision allocation_decision&.to_builder
      offence.plea plea&.to_builder
      offence.verdict verdict&.to_builder
      offence.offenceFacts offence_facts&.to_builder
      offence.laaApplnReference laa_reference&.to_builder
      offence.custodyTimeLimit custody_time_limit&.to_builder
    end
  end
  # rubocop:enable Metrics/MethodLength
end
